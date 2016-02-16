
Rails

Add sinatra to your Gemfile:

# if you require 'sinatra' you get the DSL extended to Object
                        gem 'sinatra', :require => nil
Add the following to your config/routes.rb:

    require 'sidekiq/web'
mount Sidekiq::Web


