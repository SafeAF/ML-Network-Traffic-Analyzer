

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
#### ADAPTIVE DEFENSE INFRASTRUCTURE -- ADI v0.2.1 11-23-15   ####
#### SWITCHYARD  MIDDLEWARE                                   ####
#### Copyright (C) 2010-2015 BareMetal Networks Corporation   ####
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

['../../Lib/*/*.rb', '../app/models/' '../lib', '../db', 'lib/*'].each do |folder|
  $:.unshift File.join(ROOT, folder)
end 

 BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
 $:.unshift File.join(BASE_PATH, 'lib')

 Bundler.require(:default)
 require File.dirname(__FILE__) + '/reserver.rb'

# require File.expand_path '../reserver.rb', __FILE__

Dir["models/*.rb"].each do |file|
  require "./models/#{File.basename(file, '.rb')}"
 end

$VERSION = '0.3.2'; $DATE = '12/7/15'

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

def isactivepage(link_name)
	if (link_name == @page_name)
		return ' activelink'
	else return ''
	end
end



#set :database, "msqlite3:///sw.db"

require 'connection_pool'
require 'mongo'
require 'mongoid'
require 'json'
#require 'msg_pack'
require 'pp'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'

# bundle exec sidekiq -r ./reserver.rb
#### Installation
## apt-get install libmyslclient18 libmysqlclient18-dev
## Gem install mysql2 hiredis rspec rspec-core shoulda-matchers shoulda mongoid mongo redis
# gem install sidekiq


### worker should be required by the above statement
#require_relative 'lib/workers/db_worker.rb'

p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting SuperHighway Middleware: #{File.basename(__FILE__)}"
# Use jruby with threaded servers, possible even not because its great at long running apps
# Benchmark everything

$logger = Logger.new('shlog', 'w')

#configure :development do
#	enable :logging, :dump_errors, :inline_templates
#	enable :methodoverride
	#set :root, File.dirname(__FILE__)
#	logger = Logger.new($stdout)

#	Mongoid.configure do |config|
#		config.logger = logger
#		config.persist_in_safe_mode = false
#	end
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


#configure do 
# set :server, :thin
# set :port, 3000
# set :environment, :production
 #end


$options = Hash.new
$options[:host] = '10.0.1.150'# '10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5
$options[:mongoDBHost] = '10.0.1.31'
$options[:mongoDBCollection] = 'dev_attrition'

Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
  Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})}


#$SHM = Redis::List.new('e:switchyard', :marshall => true)

$SHMEM = Redis::List.new('attrition:highway', :marshall => true) ## transport to bloodlust

Mongoid.load!('mongoid.yml', :development)

run SuperHighway
# run Sinatra::Application.run!


#map '/' do 
#run CORE::Switchyard
#end






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
#set :port, 3001
#
# configure do
# 	set :server, :thin
# 	set :port, 3000
# 	set :environment, :production
# end