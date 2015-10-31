require 'rubygems'
require 'bundler'

Bundler.require

require './my_sinatra_app'
run MySinatraApp

# start with bundle exec rackup