# require application load file
require File.join(File.dirname(__FILE__), '../application')

require 'bundler'
Bundler.setup(:default, :test)
require 'sinatra/base'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'


# expose models, spec and spec subdirectories
$:.unshift(File.join __FILE__, "../models")
$:.unshift(File.join __FILE__, "../spec/**")

Capybara.app = SampleApp

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
end
