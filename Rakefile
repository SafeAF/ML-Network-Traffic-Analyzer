require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'mongoid/tasks/database.rake'
require 'bundler'
require 'bundler/setup'
require 'bundler/dsl'

Dir.glob('*.rake').each {|r| import r}

CLEAN.include('**/gem', '**/*.rbc', '**/*.rbx')

Rake::TestTask.new("test") do |t|
  if File::ALT_SEPERATOR
    t.libs << 'lib/windows'
  else
    t.libs << 'lib/unix'
  end

  t.warning = true
  t.verbose = true
  #t.test_file = FileList['test/test_foo_bar']
end

#Bundler::GemHelper.install_tasks
task :default do
  system "rake --tasks"
end



task :monitor do
  # optional: Process.daemon (and take care of Process.pid to kill process later on)
  require 'sidekiq/web'
  app = Sidekiq::Web
  app.set :environment, :production
  app.set :bind, '0.0.0.0'
  app.set :port, 9494
  app.run!
end

exec(*(["bundle", "exec", $PROGRAM_NAME] + ARGV)) if ENV['BUNDLE_GEMFILE'].nil?

Bundler.setup(:default, :development)

task :default => :test

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

Bundler::GemHelper.install_tasks

task :release do
  sh "git release"
end

require 'yard'

YARD::Rake::YardocTask.new :doc do |yardoc|
  yardoc.files = %w{lib/**/*.rb - README.md}
end

desc "Run guard"
task :guard do
  sh "guard --clear"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :test do |t|
  t.pattern = "spec/**/*_spec.rb"
end