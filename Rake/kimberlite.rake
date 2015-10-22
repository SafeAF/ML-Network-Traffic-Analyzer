#Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../../KimberliteUI/config/application', __FILE__)

Rails.application.load_tasks


desc 'Run kimberlite webui for [E]mergence'
task :kimberlite do
	#system "cd Kimberlite/scripts"
	require ::File.expand_path('../../KimberliteUI/config/environment', __FILE__)
	run Rails.application
end
