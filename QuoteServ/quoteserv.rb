require 'yahoo-finance'
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'sinatra'
require 'thin'
require 'rack'

Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) { Redis.new({host: 'stack0', db: 15})}
$SHM = Redis::List.new('stock:quotes')