ENV['RACK_ENV'] = 'test'
app_file = File.join(File.dirname(__FILE__), *%w[.. .. main.rb])
require app_file
Sinatra::Application.app_file = app_file

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Sinatra::Application

class MyWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers

  def app
    Sinatra::Application
  end
end

World{ MyWorld.new }
