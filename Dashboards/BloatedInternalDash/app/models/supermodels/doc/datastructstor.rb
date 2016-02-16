
require 'connection_pool'
Datastructstor.redis = ConnectionPool.new(size: 5, timeout: 5) { Redis.new(:host => '10.0.1.17', :port => 6379) }

class Datastructstor
  include Redis::Objects

end
