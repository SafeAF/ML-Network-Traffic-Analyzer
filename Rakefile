require 'rake'
require 'bundler'

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