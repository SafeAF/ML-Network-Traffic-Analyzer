require 'redis-objects'
require 'mongoid'
require 'sidekiq'
# clear the default queue - Sidekiq::Queue.new('default').clear
# clear the retry set - Sidekiq::RetrySet.new.clear
# clear the scheduled set - Sidekiq::ScheduledSet.new.clear
# reset dashboard statistics: Sidekiq::Stats.new.reset
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis.example.com:7372/12' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis.example.com:7372/12' }
end


redis_conn = proc {
  Redis.new # do anything you want here
}
Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 5, &redis_conn)
end
Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end
# If your client is single-threaded, we just need a single connection in our Redis connection pool
Sidekiq.configure_client do |config|
  config.redis = { :host => '10.0.1.75', :namespace => 'system:database', :size => 1 }
end

# Sidekiq server is multi-threaded so our Redis connection pool size defaults to concurrency (-c)
Sidekiq.configure_server do |config|
  config.redis = {  :host => '10.0.1.75', :namespace => 'system:database' }
end
Redis.current = Redis.new(:host => '10.0.1.75', :port => 6379)

$SHM = Redis::List.new('foo')
$SHM.push "bar"
p $SHM.values
# Start up sidekiq via
# ./bin/sidekiq -r ./examples/por.rb
# and then you can open up an IRB session like so:
# irb -r ./examples/por.rb
# where you can then say
# PlainOldRuby.perform_async "like a dog", 3
#
class PlainOldRuby
  include Sidekiq::Worker
  include Redis::Objects

  def perform(how_hard="super hard", how_long=1)
    sleep how_long
    puts "Workin' #{how_hard}"
  end
end


#share a limited number of I/O connections among a larger number of threads.
class HardWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :crawler, :retry => false, :backtrace => true

  sidekiq_retries_exhausted do |msg|
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  MEMCACHED_POOL = ConnectionPool.new(:size => 10, :timeout => 3) { Dalli::Client.new }
  def perform(*args)
    MEMCACHED_POOL.with do |dalli|
      dalli.set('foo', 'bar')
    end
  end
end









#
# targets = Array.new
# targets.push '/etc/ssmtp/ssmtp.conf not found'
# targets.push 'Unable to locate mailhub'
# targets.push '(nagios) MAIL (mailed 1 byte of output; but got s...'
# targets.push '(nagios) CMD (nagios2mantis empty)'
# targets.push 'pam_unix(cron:session): session opened for user nobody'
# targets.push 'pam_unix(cron:session): session closed for user nobody'