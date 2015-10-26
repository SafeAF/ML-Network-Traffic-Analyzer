#!/usr/bin/env ruby
##################################################################
#### CALLGIRL HOTLINE  v0.3.0 10-23-15                        ####
####    GENERIC REST API ASYCHED AND THREADED ON THIN JRUBY   ####
#### Copyright (C) 2010-2015 BareMetal Networks Corporation   ####
##################################################################

###############################################################################
#### Description: CallGirl Hotline API is designed to be a template for the   #
####  most common use cases here at BareMetal Networks. It features           #
####  connections to our top three databases, mongo redis and mysql. Its also #
####  asynchronous and runs on jruby and thin, powered by EventMachine        #
###############################################################################
$VERSION = '0.3.0'
$DATE = '10/23/15'
require 'rubygems'
require 'thin'
require 'rack'
require 'thread'
require 'eventmachine'
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'logger'
require 'sinatra/base'
require 'connection_pool'
require 'active_record'
require 'mysql2'
require 'pp'

### OPTIONAL
require 'bundler/setup'
require 'sinatra'

### Todos mang

# Make it look purdy
# Include mongoid conf infile
# Include activerecord conf in filer
### Running
#bundle exec rackup -p 9500 --host 0.0.0.0

#### Installation
## apt-get install libmyslclient18 libmysqlclient18-dev
## Gem install mysql2
## gem install hiredis

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')

ROOT = File.join(File.dirname(__FILE__), '..')

['../app/models/' '../lib', '../db', 'lib/*'].each do |folder|
	$:.unshift File.join(ROOT, folder)
end

p "######################## ADI ##########################"
p "#          ADAPTIVE DEFENSE INFRASTRUCTURE            #"
p "#######################################################"
p "##########  Switchyard RESTful API Server  ############"
p "#######################################################"
p "#v#{$VERSION} Codename: She's Thin, With A Great Rack!#"
p "#######################################################"
p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting Switchyard Middleware: #{File.basename(__FILE__)}"

$logger = Logger.new('switchyard.log', 'w')

$options = Hash.new
$options[:host] = '10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5
#if ARGV[1].? '--db-config'
#ActiveRecord::Base.$logger = Logger.new('log/db.log')
#ActiveRecord::Base.configurations = YAML::load(IO.read('../config/database.yml'))
#end
ActiveRecord::Base.logger = Logger.new('db.log')
#ActiveRecord::Base.establish_connection(:development)
ActiveRecord::Base.establish_connection(
		:adapter => 'mysql2',
		:database => 'emergence',
		:username => 'emergence',
		:password => '#GDU3im=86jDFAipJ(f7*rTKuc',
		:host => 'datastore2')

Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
	Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})
}

$SHM = Redis::List.new('Hotline:API', :marshal => true)

$TITLE = 'CaLLGirL HoTLiNE'
