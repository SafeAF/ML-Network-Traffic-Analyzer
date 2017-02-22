require 'sidekiq'
require 'sidekiq-superworker'
require 'connection_pool'
require 'redis-objects'
require 'mongoid'
require 'mongo'
require 'net/ssh'
require 'net/ping'
require 'rye'
$SYSTEMSTACK0 = '10.0.1.75'
Redis::Objects.redis = ConnectionPool.new(size: 15, timeout: 5) {
  Redis.new({host: $SYSTEMSTACK0, port: 6379, db: 10})}

###

$SHM = Redis::HashKey.new('system:vservers')
p $SHM.all
p $SHM
p $SHM['10.0.1.60']