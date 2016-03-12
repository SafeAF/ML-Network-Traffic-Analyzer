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
  config.redis = { url: "redis://#{$SYSTEMSTACK0}:6379/10", namespace: $options[:sknamespace] }
  #  config.redis = { url: $SYSTEMSTACK0 }
end

Sidekiq.configure_client do |config|
#  config.redis = ConnectionPool.new(size: 5, &redis_conn)
  config.redis = { url: "redis://#{$SYSTEMSTACK0}:6379/10", namespace: $options[:sknamespace] }
end

$logger.info "Sidekiq Redis Namespace  #{$options[:sknamespace]}"
Sidekiq.default_worker_options = { 'backtrace' => true , :dead => false}


##############

## load in a 'cron' type dealio of scheduled jobs, maybe use sidekiq extension to do this

###

#########################################################################################
p "END INITIALIZATION SECTION"
$logger.info "End Initialization"
#########################################################################################
