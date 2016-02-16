require 'connection_pool'

## Redis initializer
require 'redis'
Redis.current = ConnectionPool.new(size: 15, timeout: 5) {
  Redis.new(:host => '10.0.1.75', :port => 6379, :db => '10') }

Rails.logger
### Notes ### Creates $redis global avail across app, $redis.set("key", "foo"), $redis.get("key")
$redis = Redis::Namespace.new("attrition", :redis => Redis.current)