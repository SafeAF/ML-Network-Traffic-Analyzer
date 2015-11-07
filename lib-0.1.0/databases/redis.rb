


Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
	Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})
}

$SHM = Redis::List.new('application:general', :marshal => true)
