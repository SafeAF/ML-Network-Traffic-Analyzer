## Add this directory to path
$:.unshift File.join(File.dirname(__FILE__))
ROOT = File.join(File.dirname(__FILE__), '..')

['../app/models/' '../lib', '../db'].each do |folder|
  $:.unshift File.join(ROOT, folder)
end

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')

Dir[File.dirname(__FILE__) + '../lib*.rb'].each do |file|
  require File.basename(file, File.extname(file))
end

require 'sidekiq'
require 'sidekiq-superworker'
require 'connection_pool'
require 'redis-objects'
require 'mongoid'
require 'mongo'
require 'net/ssh'
require 'logger'
require 'rye'
#require_relative 'initialization-routines'
### make these autoloads?
require_relative 'vanguard-workers'
require_relative '../Keystone/models/systemicAttrition'
require_relative '../Keystone/models/systemicTitan'
require_relative '../Universe/Gathering/scanning'
require_relative '../Keystone/models/user'
require_relative './preprocessors'

require 'vCore'

$VERSION = '1.0.1'
$DATE = '12/15/15'
$logger = Logger.new File.new('hypervisor.log', 'w')

p "############################### Vanguard ###################################"
$logger.info "########## VANGUARD ##########"

#########################################################################################
# Notes
#########################################################################################
# Clients push job onto queque, server does actual processing.
# Use sidekiq for high latency io like network requests
# use delayed job for cpu intensive jobs
#
# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://redis.example.com:7372/12' }
# end
#
# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://redis.example.com:7372/12' }
# end#
# thin -C production-thin.yml -R config.ru start
# bundle exec sidekiq -r ./reserver.rb
#########################################################################################
# BEGIN INITIALIZATION SECTION -> DO NOT MODIFY UNLESS GOOD REASON
#########################################################################################
module Mongoid
  module Config
    def load_configuration_hash(settings)
      load_configuration(settings)
    end
  end
end
#########################################################################################
$options = Hash.new
$options[:namespace] = 'vanguardcore'
#########################################################################################
$ATTRITIONDB = '5'
$SYSTEMSTACK0 = '10.0.1.75'
#$SYSTEMSTACK0 = 'redis://10.0.1.75:6379' + $ATTRITIONDB
$SYSTEMSTACK1 = 'redis://10.0.1.150:6379' + $ATTRITIONDB
$SYSTEMSTACK2 = 'redis://10.0.1.151:6379' + $ATTRITIONDB
$SERVER_CONCURRENCY = 25
$CLIENT_CONCURRENCY = 5
#########################################################################################
Redis::Objects.redis = ConnectionPool.new(size: 15, timeout: 5) {
  Redis.new({host: $SYSTEMSTACK0, port: 6379, db: 10})}
#########################################################################################
$SHM = Redis::HashKey.new('system:sharedmem')
$SM = Redis::List.new('system:sharedmem')
#########################################################################################
#redis_conn = proc {Redis.new(host: $SYSTEMSTACK0, port: 6379, db: 5)}
Sidekiq.configure_server do |config|
  # runs after your app has finished initializing but before any jobs are dispatched.
  config.on(:startup) do
    # make_some_singleton
  end
  config.on(:quiet) do
    puts "Got USR1, stopping further job processing..."
  end
  config.on(:shutdown) do
    puts "Got TERM, shutting down process..."
    # stop_the_world
  end
  $options[:mongodb] = 'attrition'
  $options[:mongoconnector] = ARGV[1] || '10.0.1.30:27017'
  $options[:sknamespace] = 'vanguard'
  Redis::Objects.redis = Sidekiq.redis
  Mongoid.load!('mongoid.yml', :development)
  $MONGO = Mongo::Client.new([$options[:mongoconnector]], :database => $options[:mongodb])

  $logger = Mongo::Logger.logger = Logger.new($stdout);Mongo::Logger.logger.level = Logger::INFO

  $logger.info  "Connecting to MongoDB @ #{$options[:mongoconnector]}, using database: #{$options[:mongodb]}"

  Mongoid.load!('mongoid.yml', :development)

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=#{$SERVER_CONCURRENCY}"
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']) # this arg passing method req now
  end

  #config.redis = ConnectionPool.new(size: 27, &redis_conn) # must be concur+2
  config.redis = { url: "redis://#{$SYSTEMSTACK0}:6379/10", namespace: $options[:namespace] }
  #  config.redis = { url: $SYSTEMSTACK0 }
end

Sidekiq.configure_client do |config|
#  config.redis = ConnectionPool.new(size: 5, &redis_conn)
  config.redis = { url: "redis://#{$SYSTEMSTACK0}:6379/10", namespace: $options[:namespace] }
end

$logger.info "Sidekiq Redis Namespace  #{$options[:namespace]}"
Sidekiq.default_worker_options = { 'backtrace' => true , :dead => false}

#################

#$logger.info "Standalone mongo: #{$MONGO.cluster.servers.first.standalone?}"
##############

## load in a 'cron' type dealio of scheduled jobs, maybe use sidekiq extension to do this
###

#########################################################################################
p "END INITIALIZATION SECTION"
$logger.info "End Initialization"
##################"stack"#######################################################################

######################################################################################
## Powerplant Workers Akashic
## Sidekiq.redis is an exposed redis handle, yay!
##   Sidekiq.redis { |conn| conn.del(lock) }
## Sidekiq.logger exposes logging functionality
##  Sidekiq.logger.warm "foo bar"

### Calling Workers

#MyWorker.perform_async(1, 2, 3)
#Sidekiq::Client.push('class' => MyWorker, 'args' => [1, 2, 3])  # Lower-level generic API

#####################################################################################

#### Sidekiq Sueprworker

# Superworker.define(:MySuperworker, :user_id, :comment_id) do
#   Worker1 :user_id
#   Worker2 :user_id do
#     parallel do
#       Worker3 :comment_id do
#         Worker4 :comment_id
#         Worker5 :comment_id
#       end
#       Worker6 :user_id do
#         parallel do
#           Worker7 :user_id
#           Worker8 :user_id
#           Worker9 :user_id
#         end
#       end
#     end
#     Worker10 :comment_id
#   end
# end

## Coordinate all the titan jobs
# class TitanHighCommander(*args)
#
# end


