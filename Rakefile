
#require "rspec/core/rake_task"
require 'rubygems'
require 'bundler'

require 'rake'
#require 'bundler/gem_tasks'
require 'rake/testtask'
	require 'rake'
require 'find'



Rake::TestTask.new(:testClient) do |t|
	sh "date"
	t.libs << "test" # "test-unit"
#	t.libs << "test-unit" # "test-unit"
	t.test_files = FileList['Client/tests/test*.rb']
	t.verbose = true
end


#bundle config --delete bin    # Turn off Bundler's stub generator
#rake rails:update:bin         # Use the new Rails 4 executables
#git add bin                   # Add bin/ to source control


namespace :dev do
	desc 'rails update via delete bin stubs and update bin rake task + add to git '
	task :update do
		bundle
	end

 desc 'cleans up logfiles'
 task :delog do 
 file_paths = []
 dir = Dir.getwd
  Find.find(dir).select {|path| /.*\.log$/ =~ path }
  
  p file_paths
p "hello"
	end

desc 'populates new rails app with supermodels, pick which sets'
  task :supermodels

end

desc 'startup Emergence/Attrition backend'
task :emerge

end
end



#Bundler.setup


task :default => [:foo] #, :test]



	task :foo do
#	p Time.now
#	p "foo"
end

#Dir["Rake/*.rake"].sort.each { |ext| load ext }