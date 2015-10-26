
require "rspec/core/rake_task"
require 'rubygems'
require 'bundler'

require 'rake'
#require 'bundler/gem_tasks'
require 'rake/testtask'


Rake::TestTask.new(:testClient) do |t|
	sh "date"
	t.libs << "test" # "test-unit"
#	t.libs << "test-unit" # "test-unit"
	t.test_files = FileList['Client/tests/test*.rb']
	t.verbose = true
end

#Bundler.setup


task :default => [:foo, :test]



	task :foo do
	p Time.now
	p "foo"
end

#Dir["Rake/*.rake"].sort.each { |ext| load ext }