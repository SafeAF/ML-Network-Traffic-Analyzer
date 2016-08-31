require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'mongoid/tasks/database.rake'
require 'bundler'
require 'bundler/setup'
require 'bundler/dsl'

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