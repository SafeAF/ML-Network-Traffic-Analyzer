#!/usr/bin/env ruby
require 'pp'
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'activerecord'
require 'connection_pool'
hSuDir[File.dirname(__FILE__) + '../lib*.rb'].each do |file|
	require File.basename(file, File.extname(file))
end

$options = {}
$options[:host] = '10.0.1.17'
$options[:db] = 1
$options[:port] = '6379'
$options[:table] = 'system:log'


#ActiveRecord::Base.logger = Logger.new('log/db.log')
#	ActiveRecord::Base.configurations = YAML::load(IO.read('../config/database.yml'))
#end
#ActiveRecord::Base.establish_connection('development')
ActiveRecord::Base.establish_connection(
		:adapter => 'mysql2',
		:database => 'emergence',
		:username => 'emergence',
		:password => '#GDU3im=86jDFAipJ(f7*rTKuc',
		:host => 'datastore2')

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
	Redis.new({host: $options[:host], port: $options[:port], db: $options[:db]})}

$SHM = Redis::List.new('system:log', :marshall => true)