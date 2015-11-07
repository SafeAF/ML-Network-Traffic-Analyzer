require 'connection_pool'

## Redis initializer
require 'redis'
Redis.current = ConnectionPool.new(size: 5, timeout: 5) {
	Redis.new(:host => 'localhost', :port => 6379) }

### Notes ### Creates $redis global avail across app, $redis.set("key", "foo"), $redis.get("key")
$redis = Redis::Namespace.new("callgirl", :redis => Redis.current)