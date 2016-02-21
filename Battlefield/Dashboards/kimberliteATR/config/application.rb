require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kimberlite
  class Application < Rails::Application
    
      config.to_prepare do
        Devise::SessionsController.layout 'admin_lte_2_login'
      end
      
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # PRODUCTION : CACHING
    #config.autoload_paths += %W(#{config.root}/lib}) ## requires anything in lib
    # Do not swallow errors in after_commit/after_rollback callbacks.
    #config.active_record.raise_in_transactional_callbacks = true

    #config.cache_store = :redis_store, "redis://10.0.1.17:6379/0/cache", {
     #   expires_in: 120.minutes }
    #...


    config.active_job.queue_adapter = :sidekiq
    # job que production_que_name staging_que_name etc
    config.active_job.queue_name_prefix = Rails.env

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # config.cache_store = :redis_store, "redis://10.0.1.17:6379/0/cache", {
    #      expires_in: 120.minutes }
   # config.action_dispatch.session_store = :active_record_store
    config.action_dispatch.session_store = :redis_store
    config.force_ssl = false

    config.consider_all_requests_local = true #FIXME set to false in prod

    console do
      require 'pry'
      config.console = pry
    end

  end
end
