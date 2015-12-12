require './dependencies'
(Dir['./lib/*.rb'].sort).each do |file|
  load file
end

class Main < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :sprockets, Sprockets::Environment.new(root)
  sprockets.cache = Sprockets::Cache::MemcacheStore.new
  set :digest_assets, false
  set :assets_precompile, [/^([a-zA-Z0-9_-]+\/)?([a-zA-Z0-9_-]+\/)?(?!_)([a-zA-Z0-9_-]+.\w+)$/]
  set :assets_prefix, %w(assets)
  set :assets_protocol, :http
  set :assets_paths, %w(fonts images javascripts stylesheets)
  set :assets_css_compressor, YUI::CssCompressor.new
  set :assets_js_compressor, :uglifier
  set :assets_compress, $env == 'development' ? false : true

  register Sinatra::AssetPipeline

  Slim::Engine.options[:disable_escape] = true

  YAML::load(File.open('config/database.yml'))[$env].each do |key, value|
    set key, value
  end

  configure $env.to_sym do
    enable :raise_errors, :sessions, :logging

    ActiveRecord::Base.establish_connection(adapter: settings.adapter,
                                            username: settings.username,
                                            password: settings.password,
                                            host: settings.host,
                                            database: settings.database)

    assets_paths.each do |path|
      sprockets.append_path File.join(root, 'app', 'assets', path)
    end

    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix = assets_prefix
      config.digest = digest_assets
      config.public_path = public_folder
    end

  end


  (Dir['./app/helpers/*.rb'].sort + Dir['./app/concerns/*.rb'].sort + Dir['./app/models/*.rb'].sort  + Dir['./app/controllers/*/*.rb'].sort).each do |file|
    require file
  end

end
