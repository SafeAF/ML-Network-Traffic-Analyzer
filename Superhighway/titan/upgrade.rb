#!/usr/bin/ruby
# @Author: Samuel Kerr
# @Date:   2016-09-01 19:46:43
# @Last Modified by:   Samuel Kerr
# @Last Modified time: 2016-09-12 19:01:52

$VERSION = '0.1.0'

require 'rye'


servers = %w[app0 app1 app2 app3 app4 app5 dev0 dev1 dev2 dev3 stack0 stack1 stack2 stack3]
 servers.push %w{internal manager0 manager1 datastore0 datastore1 datastore2 datastore3 datastore4 datastore5}

require 'connection_pool'
require 'redis-objects'
require 'mongoid'
require 'mongo'


#########################################################################################
# BEGIN INITIALIZATION SECTION -> DO NOT MODIFY UNLESS GOOD REASON
#########################################################################################
module Mongoid
  module Config
    def load_configuration_hash(settings)
      load_configuration(settings)
    end
  end
end
Mongoid.load!('mongoid.yml', :development)

$ATTRITIONDB = '5'
$SYSTEMSTACK0 = '10.0.1.75'
# $SYSTEMSTACK0 = 'redis://10.0.1.75:6379' + $ATTRITIONDB
$SYSTEMSTACK1 = 'redis://10.0.1.150:6379' + $ATTRITIONDB
$SYSTEMSTACK2 = 'redis://10.0.1.151:6379' + $ATTRITIONDB
$SERVER_CONCURRENCY = 25
$CLIENT_CONCURRENCY = 5
#########################################################################################
Redis::Objects.redis = ConnectionPool.new(size: 15, timeout: 5) {
  Redis.new({host: $SYSTEMSTACK0, port: 6379, db: 10})}
#########################################################################################
$SHM = Redis::HashKey.new('system:sharedmem')
$SM = Redis::List.new('system:sharedmem')
#########################################################################################
$options = {}
$options[:mongodb] = 'attrition'
$options[:mongoconnector] = ARGV[1] || '10.0.1.30:27017'

$MONGO = Mongo::Client.new([$options[:mongoconnector]], :database => $options[:mongodb])

$logger = Mongo::Logger.logger = Logger.new($stdout);Mongo::Logger.logger.level = Logger::INFO

$logger.info  "Connecting to MongoDB @ #{$options[:mongoconnector]}, using database: #{$options[:mongodb]}"
p $MONGO.cluster.servers.first.standalone?