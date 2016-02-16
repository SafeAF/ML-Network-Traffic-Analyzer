# This file is used by Rack-based servers to start the application.

require 'sidekiq/web'
# use if fails in production (due to caching not serving sidekiqs css js from its gem)
# run Rack::URLMap.new(
#     "/" => Rails.application,
#     "/sidekiq" => Sidekiq::Web
# )
set :port, 4000
require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
