
Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
  Redis.new({host: '10.0.1.75', port: 6379, db: 10})}

$SHM = Redis::List.new('system:stats', :marshal => true) #, :expiration => 5)


p $SHM.values