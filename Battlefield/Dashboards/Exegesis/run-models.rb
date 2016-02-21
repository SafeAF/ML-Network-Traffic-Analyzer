## BEGIN INIT #####################################################################
require 'connection_pool';require 'redis-objects';require 'mongo';require 'mongoid';require 'sinatra/base'
require 'json'; require 'pp'
require File.expand_path(File.dirname(__FILE__) + '/libtimongo');require File.expand_path(File.dirname(__FILE__) + '/libnetutils')
$options = {};$options[:redhost] = ARGV[0] || '10.0.1.75' ;$options[:redport] = '6379'
$options[:redtable] = 5 ;$options[:mongodb] = 'titan'
$options[:mongoconnector] = ARGV[1] || '10.0.1.30:27017'
Redis::Objects.redis = ConnectionPool.new(size: 15, timeout: 5) {
  Redis.new({host: $options[:redhost], port: $options[:redport], db: $options[:redtable]})}
Mongoid.load!('mongoid.yml', :development)
$MONGO = Mongo::Client.new([$options[:mongoconnector]], :database => $options[:mongodb])
$logger = Mongo::Logger.logger = Logger.new($stdout);Mongo::Logger.logger.level = Logger::INFO
$logger.info  "Connecting to MongoDB @ #{$options[:mongoconnector]}, using database: #{$options[:mongodb]}"
$logger.info "Connecting to Redis @ #{$options[:redhost]}, using database: #{$options[:redtable]}"


serv = Vserver.new
serv.address = '10.0.1.63'
serv.hostname = 'app3'
serv.up = true
serv.save!


