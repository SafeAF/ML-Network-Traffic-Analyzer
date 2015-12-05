$VERSION = '0.2.1'
$DATE = '07/15/15'
require 'rubygems'
require 'thin'
require 'rack'
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'logger'
require 'sinatra/base'
require 'connection_pool'
require 'active_record'
require 'mysql2'
require 'pp'

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')
ROOT = File.join(File.dirname(__FILE__), '..')
['../app/models/' '../lib', '../db', 'lib/*'].each do |folder|
  $:.unshift File.join(ROOT, folder); end
p "######################## ADI ##########################"
p "#          ADAPTIVE DEFENSE INFRASTRUCTURE            #"
p "#######################################################"
p "##########  Switchyard TESTful API Server  ############"
p "#######################################################"
p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting Switchyard Middleware: #{File.basename(__FILE__)}"

p "************END INIT************"


$options = Hash.new
$options[:host] = '10.0.1.17'# '10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5

Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
  Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})
}

$SHM = Redis::List.new('e:switchyard', :marshall => true)

bar = 'baz'
$SHM.push(bar)
$SHM.push("bazzz", "bjddjd", "kdjksljf")

p $SHM.shift
p $SHM.shift
p $SHM.shift
p $SHM.shift
