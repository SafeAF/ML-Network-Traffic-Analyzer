$:.unshift File.join(__FILE__, "../config")

require 'sinatra/base'
# require 'sinatra/contrib'
require 'mongoid'
require 'bundler/setup'
require 'pry'
require 'sample_app_config'
require 'routes'

class SampleApp < Sinatra::Base
  set :app_file, __FILE__
  set :views, settings.root + '/views'
end