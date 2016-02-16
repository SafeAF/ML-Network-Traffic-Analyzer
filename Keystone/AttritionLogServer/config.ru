# ['../../Lib/*/*.rb', '../app/models/' '../lib', '../db', 'lib/*'].each do |folder|
#   $:.unshift File.join(ROOT, folder)
# end
#
# BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
# $:.unshift File.join(BASE_PATH, 'lib')
#
# # require File.expand_path '../reserver.rb', __FILE__
## Required to be able to load
module Mongoid
  module Config
    def load_configuration_hash(settings)
      load_configuration(settings)
    end
  end
end

require 'mongoid'

=begin
##################################################################
#### ADAPTIVE DEFENSE INFRASTRUCTURE - SWITCHYARD v0.7.0      ####
#### SWITCHYARD LOGSERV MIDDLEWARE v0.1.0 1/1/16              ####
#### Copyright (C) 2010-2016 BareMetal Networks Corporation   ####
##################################################################
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###############################################################################
#### Switchyard is the API of Emergence and the only component that is exposed
#### to the internet, client daemons connect and upload logfiles and download
#### configurations and ban lists
###############################################################################
=end

ROOT = File.join(File.dirname(__FILE__), '..')
BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')
Dir["models/*.rb"].each do |file|
  require "./models/#{File.basename(file, '.rb')}"
end

Bundler.require(:default)
require File.dirname(__FILE__) + '/LogServer'

$VERSION = '0.1.0'; $DATE = '1/1/15'

require 'bundler/setup'
#require 'bson_ext'
require 'bson'
require 'rubygems'
require 'thin'
require 'rack'
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'logger'
#require 'sinatra'
require 'sinatra/base'
#require 'sinatra/activerecord'
#gem 'sinatra-contrib', :require => 'sinatra/multi_route'
#gem 'sinatra-partial', :require => 'sinatra/partial'
#gem 'sinatra-reloader' #if development?

require 'connection_pool'
require 'mongo'
require 'mongoid'
require 'json'
require 'msgpack'
require 'pp'
# require 'sidekiq'
# require 'sidekiq/web'
# require 'sidekiq/api'


$options = Hash.new
$options[:mongoDBHost] = '10.0.1.30'
$options[:mongoDBCollection] = 'dev_logserver'



# #$redis = Redis.current
# $LOGSERV = Redis::List.new('switchyard:logserver', :marshal => true)
#
# $BLOOD = Redis::List.new('yard:connector', :marshal => true) ## transport to bloodlust

# Mongoid.load!('mongoid.yml', :development)

#  thin -C production-thin.yml -R config.ru start
# bundle exec sidekiq -r ./reserver.rb
#### Installation
## apt-get install libmyslclient18 libmysqlclient18-dev
## Gem install mysql2 hiredis rspec rspec-core shoulda-matchers shoulda mongoid mongo redis
# gem install sidekiq

p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting Switchyard Middleware: #{File.basename(__FILE__)}"
# Use jruby with threaded servers, possible even not because its great at long running apps
# Benchmark everything
#require 'your_app'

# require 'sidekiq/web'
# run Rack::URLMap.new('/' => Sinatra::Application, '/sidekiq' => Sidekiq::Web)

run LogServ






# run Sinatra::Application.run!


#map '/' do 
#run CORE::Switchyard
#end




#Mongoid.database = Mongo::Connection.new($options[:mongoDBHost].db($options[:mongoDBCollection]))

=begin
Mongoid.configure do |config|
	name = $options[:mongoDBCollection]
	host = $options[:mongoDBHost]
	config.master = Mongo::Connection.new.db(name)
	config.persist_in_safe_mode = false

end
=end


# app = proc do |env|
#   body = ['hi']
#   [
#       200, {'Content-Type' => 'text/html'},
#       body
#   ]
# end
#
# run Rack::URLMap.new({
#                          '/' => Public,
#                          'config' => Protected,
#                          '/logs' => Protected,
#                      })
