# run with
# thin -C production-thin.yml -R config.ru start
# production-thin.yml
# address: localhost
# port: 3020
# servers: 4
# max_conns: 1024
# max_persistent_conns: 512
# timeout: 30
# environment: production
# pid: tmp/pids/thin-production.pid
# log: log/thin-production.log
# daemonize: true
#Bundler.require(:default)
require File.dirname(__FILE__) + '/messagehub.rb'

# require File.expand_path '../reserver.rb', __FILE__

Dir["models/*.rb"].each do |file|
  require "./models/#{File.basename(file, '.rb')}"
end

$VERSION = '0.3.2'; $DATE = '12/7/15'

#require 'bundler/setup'
#require 'bson_ext'
#require 'bson'
require 'rubygems'
require 'thin'
require 'rack'
#require 'hiredis'
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
#require 'mongo'
#require 'mongoid'
require 'json'
#require 'msg_pack'
require 'pp'
#equire 'sidekiq'
#require 'sidekiq/api'
#require 'sidekiq/web'

# bundle exec sidekiq -r ./reserver.rb
#### Installation
## apt-get install libmyslclient18 libmysqlclient18-dev
## Gem install mysql2 hiredis rspec rspec-core shoulda-matchers shoulda mongoid mongo redis
# gem install sidekiq


### worker should be required by the above statement
#require_relative 'lib/workers/db_worker.rb'

p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting Switchyard Middleware: #{File.basename(__FILE__)}"
# Use jruby with threaded servers, possible even not because its great at long running apps
# Benchmark everything

$logger = Logger.new('switchyard.log', 'w')
run MessageHub
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


# $options = Hash.new
# $options[:host] = '10.0.1.150'# '10.0.1.17'
# $options[:port] = '6379'
# $options[:table] = 5
# $options[:mongoDBHost] = '10.0.1.31'
# $options[:mongoDBCollection] = 'dev_yardbridge'
#
# Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
#   Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})}

#$redis = Redis.current
#$SHM = Redis::List.new('attrition:notifications', :marshall => true)

#$SHMEM = Redis::List.new('yard:connector', :marshall => true) ## transport to bloodlust

#Mongoid.load!('mongoid.yml', :development)

# run MessageHub
# run Sinatra::Application.run!
