Dir[File.dirname(__FILE__) + '../lib*.rb'].each do |file|
  require File.basename(file, File.extname(file))
end

# External deps
require 'sidekiq' ; require 'sidekiq-superworker' ; require 'connection_pool'
require 'redis-objects' ; require 'mongoid' ; require 'mongo' ; require 'net/ssh'
require 'logger' ; require 'rye' ; require 'sidekiq-encryptor'

# Internal deps
require 'guardcorelib'

### autoload?
require_relative '../Keystone/models/attritioncore'
require_relative '../Keystone/models/gridcore'
require_relative '../Keystone/models/user'
require_relative '../Keystone/models/attackers'
require_relative '../Keystone/models/reputation'

require_relative './lib/workers/bloodlust/optimized/preprocessors'
require_relative './lib/workers/bloodlust/optimized/fastml'
require_relative './lib/workers/bloodlust/optimized/postprocessors'
require_relative './lib/workers/credibility/repprocessors'
require_relative './lib/workers/grid/node/monitoring'


$VERSION = '0.4.2'
$DATE = '10/19/16'
$logger = Logger.new File.new('vcore.log', 'w')
$logger.info "############################ Vanguard Core ################################"
$logger.info "Initialization commencing"
#########################################################################################
# Notes
#########################################################################################
# Sidekiq: 'Clients' push job onto queue, 'servers' retrieves do actual processing.
#
# To start Vanguard Core you should have one of the callers online like log reception api
# Start AttritionLogAPI cluster:
# thin -C attr-api.yml -R config.ru start
# Then launch at least one instance of sidekiq with guardcore required
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
$options[:mainspace] = 'vanguardcore'
#########################################################################################
$ATTRITIONDB = '5'

$ProdStackHost = '10.0.1.75'
$SYSTEMSTACK0 = '10.0.1.75'
$CLIENT_CONCURRENCY = 5
#########################################################################################
Redis::Objects.redis = ConnectionPool.new(size: 15, timeout: 5) {
  Redis.new({host: $SYSTEMSTACK0, port: 6379, db: 10})}
#########################################################################################
$HEAP = Redis::HashKey.new('system:heap')
$STACK = Redis::List.new('system:stack')
#########################################################################################
#redis_conn = proc {Redis.new(host: $SYSTEMSTACK0, port: 6379, db: 5)}
Sidekiq.configure_server do |config|
  # config.server_middleware do |chain|
  #   chain.add Sidekiq::Encryptor::Server, key: ENV['SIDEKIQ_ENCRYPTION_KEY']
  # end
  # config.client_middleware do |chain|
  #   chain.add Sidekiq::Encryptor::Client, key: ENV['SIDEKIQ_ENCRYPTION_KEY']
  # end

  # runs after your app has finished initializing but before any jobs are dispatched

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
  #Redis::Objects.redis = Sidekiq.redis
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
  config.redis = { url: "redis://#{$SYSTEMSTACK0}:6379/10", namespace: $options[:mainspace] }
  #  config.redis = { url: $SYSTEMSTACK0 }
  $logger.info "Server Middleware connected to #{$SYSTEMSTACK0}"
end

Sidekiq.configure_client do |config|
#  config.redis = ConnectionPool.new(size: 5, &redis_conn)
  config.redis = { url: "redis://#{$SYSTEMSTACK0}:6379/10", namespace: $options[:mainspace] }
  $logger.info "Client Middleware connected to #{$SYSTEMSTACK0}"
    config.client_middleware do |chain|
    chain.add Sidekiq::Encryptor::Client, key: ENV['SIDEKIQ_ENCRYPTION_KEY']
  end
end

$logger.info "Sidekiq Redis Namespace  #{$options[:mainspace]}"
Sidekiq.default_worker_options = { 'backtrace' => true , :dead => false}
$logger.info "Sidekiq Default Worker Options: #{Sidekiq.default_worker_options.inspect}"
#################

#$logger.info "Standalone mongo: #{$MONGO.cluster.servers.first.standalone?}"
##############

## load in a 'cron' type dealio of scheduled jobs, maybe use sidekiq extension to do this
###

#########################################################################################

$logger.info "END INIT"
##################"stack"#######################################################################


################################

######################################################################################
## Powerplant Workers 
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


