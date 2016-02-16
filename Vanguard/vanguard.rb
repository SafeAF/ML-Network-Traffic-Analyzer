require 'sidekiq'
require 'sidekiq-superworker'
require 'connection_pool'
require 'redis-objects'
require 'mongoid'
require 'mongo'
require 'net/ssh'
require 'net/ping'
require 'rye'
require_relative 'vanguard-workers'
#require_relative './Credibility/user'
p "############################### Vanguard ##########################"

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

###

$SHM = Redis::HashKey.new('system:vservers')
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

  Mongoid.load!('mongoid.yml', :development)

  # database_url = ENV['DATABASE_URL']
  # if database_url
  #   ENV['DATABASE_URL'] = "#{database_url}?pool=#{$SERVER_CONCURRENCY}"
  #   ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']) # this arg passing method req now
  # end

  #config.redis = ConnectionPool.new(size: 27, &redis_conn) # must be concur+2
  config.redis = { url: "redis://#{$SYSTEMSTACK0}:6379/10", namespace: 'vanguard' }
  #  config.redis = { url: $SYSTEMSTACK0 }
end

Sidekiq.configure_client do |config|
#  config.redis = ConnectionPool.new(size: 5, &redis_conn)
  config.redis = { url: "redis://#{$SYSTEMSTACK0}:6379/10", namespace: 'vanguard' }
end


Sidekiq.default_worker_options = { 'backtrace' => true , :dead => false}
#########################################################################################
#########################################################################################

### Calling Workers

#MyWorker.perform_async(1, 2, 3)
#Sidekiq::Client.push('class' => MyWorker, 'args' => [1, 2, 3])  # Lower-level generic API

def check_server_availability(ip, service='ssh')
  ping = Net::Ping::TCP.new(ip, service)
  ping.ping?
end


module Mongoid
  module Config
    def load_configuration_hash(settings)
      load_configuration(settings)
    end
  end
end
######################################################################################
## Powerplant Workers Akashic
## Sidekiq.redis is an exposed redis handle, yay!
##   Sidekiq.redis { |conn| conn.del(lock) }
## Sidekiq.logger exposes logging functionality
##  Sidekiq.logger.warm "foo bar"
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



class TitanCommander
  include Sidekiq::Worker

  def perform(cmd = 'who', host = 'all', user = 'vishnu', ryeset=nil)
   rbox = Rye::Box.new(host, {user: user})
    rbox.disable_safe_mode
    ret = rbox.execute cmd
    Sidekiq.redis {|conn| ret.stdout}
    ret.stderr
    ret.exit_status
  end
end

__END__
class AttritionSuperWorker
  include Sidekiq::Worker # :retry => false
  sidekiq_options :queue => :attrition , :backtrace => true, :retry => 5, :dead => false

  sidekiq_retries_exhausted do |msg|
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(name, count)
    # #$redis = Redis.current
    # $LOGSERV = Redis::List.new('switchyard:logserver', :marshal => true)
    #
    # $BLOOD = Redis::List.new('yard:connector', :marshal => true) ## transport to bloodlust

  end
end

end

class PruneDatabase
  include Sidekiq::Worker
  include Mongoid::Document
  include Redis::Objects
  #include Sidekiq::Benchmark::Worker

  def self.defer
    perform_async
    sidekiq_options :retry => 25, :dead => true, :queue => syslog
  end
end


def LogPreProcessor
  include Sidekiq::Worker

  def perform(logs)

  end


end

module  VanguardCommander
 extend self # make module methods class mehtods

def self.subscribe
  @channel = defined?(CHANNEL) ? CHANNEL : 'job_server'
  @pubsub = Redis.new
  @pubsub.subscribe(@channel) do |on|
    on.message do |channel, msg|

      # message
      data = JSON.parse(msg)

      # process jobs this worker knows how to complete
      if WorkerMethods.respond_to? data['task']
        do_next_task data['task']
      end

    end
  end
end
end

















  # Gush
  #     Defining workflows
  #     The DSL for defining jobs consists of a single
  #               run  method. Here is a complete example of a workflow you can
  #               create:
  # workflows/sample_workflow.rb

  # class SampleWorkflow < Gush::Workflow
  #   def configure(url_to_fetch_from)
  #     run FetchJob1, params: { url: url_to_fetch_from }
  #     run FetchJob2, params: {some_flag: true, url: 'http://url.com'}
  #     run PersistJob1, after: FetchJob1
  #     run PersistJob2, after: FetchJob2
  #     run Normalize,
  #         after: [PersistJob1, PersistJob2],
  #         before: Index
  #     run Index
  #   end
  # end

  # Hint: For debugging purposes you can vizualize the graph using
  # viz  command:
  #          bundle exec gush viz SampleWorkflow
