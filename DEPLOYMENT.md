


## Gems to install

   gem install
   rspec rspec-mock factory_girl cucumber thin puma sinatra mongoid redis-objects 
   ruby-fann

   use rvm to install ruby-2.2.1 and jruby

   benchmark servers and other code upon deployment and compare mri and jruby esp for long running servers - jruby is probably faster.gem install g  


## Switchyard Sidekiq
 
__First Start Sidekiq__

    bundle exec sidekiq -r ./lib/switch_worker.rb

__Then Switchyard__

    bundle exec rackup 

__Dashboards__ 

The sidekiq dashboard is at /sidekiq, and the switchyard dashboard is at /dashboard or you can view it via the api and the main control dashboard for Attrition.. Overmind at overmind.internal.clusterforge.us

