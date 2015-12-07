#!/usr/bin/env ruby
require 'hiredis'
require 'redis'
require 'redis-objects'



Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
    Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})
}

$SHM = Redis::List.new('e:switchyard', :marshall => true)


red = Hash.new
red[:time], red[:src], red[:dst], red[:sport], red[:dport] = '20140821', '192.168.9.1', '192.168.10.1', '2933', '1902'
red[:features] = [0.221, 0.2123, 0.14312, 0.1232, 0.1412, 0.1421, 0.2532, 0.2252, 0.2141, 0.4214, 0.4141,0.114, 0.414]


$SHM.push(red)