
require 'redis-objects'
require 'redis'
require 'mongo'
require 'mongoid'
require 'highline'
require 'readline'
require 'connection_pool'
## Provides a repl that hooks into battlefield to view state, and also into credibility db
#!/usr/bin/env ruby
require 'redis-objects'
require 'mongoid'
require 'sidekiq'
require 'mongo'

redis_conn = proc {
  Redis.current = Redis.new(:host => '10.0.1.75', :port => 6379, :db => 5)
}
Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 15, &redis_conn)
end
Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end

$PSHM = Redis::List.new('system:database')


class RedisExcersizerWorker
  include Sidekiq::Worker
  include Redis::Objects

  def perform(how_hard="super hard", how_long=1)
    sleep how_long
    puts "Workin' #{how_hard}"
    $PSHM.push "test foo bar #{rand(1..10)}"
  end
end

