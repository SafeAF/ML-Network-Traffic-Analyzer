# main.rb for bloodlust

ROOT = File.join(File.dirname(__FILE__), '..')
# load in directories with modules and lbis etc
['../Lib/models/*' '../lib', '../db', 'lib/*'].each do |folder|
	$:.unshift File.join(ROOT, folder)
end

require 'rubygems'
require 'ruby_fann'
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'logger'


$options = Hash.new
$options[:host] = 'localhost' #'10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5


Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
	Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})
}

$SHM = Redis::List.new('e:switchyard', :marshall => true)
