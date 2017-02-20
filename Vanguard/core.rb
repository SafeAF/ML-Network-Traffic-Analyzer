p "#################################################################################"
p '#          $$    [GRIDCORE] $$ {Vanguard} [Core*Hypervisor]  $$                 #'
p '         Hypervisor for TiTAN V Perpetual Asynchronous Worker Swarm             #'
p '      Background processing with Sidekiq for Attrition and Other Services       #'
p 'r#################################################################################'

Dir[File.dirname(__FILE__) + '../lib*.rb'].each do |file|
	require File.basename(file, File.extname(file))
end
require 'bundler'
Bundler.setup(:default)
Bundler.require(:default)

# External deps
require 'connection_pool'; require 'redis'; require 'logger' ;
require 'redis-objects' ; require 'mongoid' ; require 'mongo';
require 'sidekiq'
require 'sidekiq-superworker'

module Mongoid
	module Config
		def load_configuration_hash(settings)
			load_configuration(settings)
		end
	end
end

# Internal deps
#require 'gridcore'

### autoload?
#require_relative '../Keystone/models/attritioncore'
#require_relative '../Keystone/models/gridcore'
#require_relative '../Keystone/models/user'
#require_relative '../Keystone/models/attackers'
#require_relative '../Keystone/models/credibility'

#require_relative './lib/workers/bloodlust/optimized/preprocessors'
#require_relative './lib/workers/bloodlust/optimized/machinelearners'
#require_relative './lib/workers/bloodlust/optimized/postprocess'

#require_relative './lib/workers/keystone/persistance'
#require_relative './lib/workers/credibility/reputation'
#require_relative './lib/workers/grid/node/monitoring'

#require_relative './lib/superworkers/overlord'
require_relative('./lib/vanguard-workers')

$VERSION = '0.5.0'
$DATE = '02/17/17'
$logger = Logger.new File.new('guardcore.log', 'w')
$logger.info "######################## Vanguard GuardCore ###########################"
$logger.info "Initialization commencing"


#########################################################################################
# Notes
#########################################################################################
# Sidekiq: 'Clients' push job onto queue, 'servers' retrieves do actual processing.
#
# To start Vanguard Core you should have one of the callers online like log reception api
# Start AttritionLogAPI cluster:
# thin -C attr-api.yml -R config.ru start
# Then launch at least one instance of sidekiq with core.rb required
# export REDISHOST=10.0.1.150 ; bundle exec sidekiq -r ./core.rb

################################
# BEGIN INITIALIZATION SECTION #
################################

$options = Hash.new
$options[:mainspace] = 'guardcore'
$options[:redAttritionDB] = '10'
$options[:mongodb] = 'vanguard'
$options[:mongoconnector] = ARGV[1] || '10.0.1.34:27017'
$options[:sknamespace] = 'vanguard'
$options[:redisHost] =  '10.0.1.34'

Redis::Objects.redis = ConnectionPool.new(size: 15, timeout: 5) {
	Redis.new({host: $options[:redisHost], port: 6379, db: $options[:redAttritionDB]})}

$HEAP = Redis::HashKey.new('system:heap') ## Depracated ## slated for removal in next major release v0.5
$logger.info '[+] Distributed Heap at $HEAP'
$STACK = Redis::List.new('system:stack')  ## Depracated ## and instead refocus on shared nothing model
#########################################################################################

############# CONFIGURE SQ SERVER ################
Sidekiq.configure_server do |config|
	config.on(:startup) do
		# make_some_singleton
	end
	config.on(:quiet) do
		puts "Got USR1, stopping further job processing..."
	end
	config.on(:shutdown) do
		puts "Got TERM, shutting down process..."
	end

	$MONGO = Mongo::Client.new([$options[:mongoconnector]], :database => $options[:mongodb])

	$logger = Mongo::Logger.logger = Logger.new($stdout);Mongo::Logger.logger.level = Logger::INFO

	$logger.info  "[+] Connecting to MongoDB @ #{$options[:mongoconnector]}, using database: #{$options[:mongodb]}"

	Mongoid.load!('mongoid.yml', :development)

	database_url = ENV['DATABASE_URL']
	if database_url
		ENV['DATABASE_URL'] = "#{database_url}?pool=#{$SERVER_CONCURRENCY}"
		ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']) # this arg passing method req now
	end

	#config.redis = ConnectionPool.new(size: 27, &redis_conn) # must be concur+2
	config.redis = { url: "redis://#{$options[:redisHost]}:6379/10", namespace: $options[:mainspace] }
	#  config.redis = { url: $SYSTEMSTACK0 }
	$logger.info "[+] Server Middleware connected to #{$options[:redisHost]}"
end
############# CONFIGURE CLIENT ##################
Sidekiq.configure_client do |config|
#  config.redis = ConnectionPool.new(size: 5, &redis_conn)
	config.redis = { url: "redis://#{$options[:redisHost]}:6379/10", namespace: $options[:mainspace] }
	$logger.info "[+] Client Middleware connected to #{$options[:redisHost]}"
end

$logger.info "[+] Sidekiq Redis Namespace  #{$options[:mainspace]}"
Sidekiq.default_worker_options = { 'backtrace' => true , :dead => false}
$logger.info "[+] Sidekiq Default Worker Options: #{Sidekiq.default_worker_options.inspect}"
#################

#$logger.info "Standalone mongo: #{$MONGO.cluster.servers.first.standalone?}"
##############

## load in a 'cron' type dealio of scheduled jobs, maybe use sidekiq extension to do this
###

#########################################################################################
#WNS INI%$ QA

$logger.info '[+] Redis handle available at Sidekiq.redis'
$logger.info '[+] End initialization'
$logger.info '############### VANGUARD OPERATIONAL ###############'
$logger.info '####################################################'
######################################################################################


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


