#!/usr/bin/env ruby

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')
$VERSION = '1.0.0'
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
require 'pp'
require 'mysql2'
require 'active_record'

ROOT = File.join(File.dirname(__FILE__), '..')

['../app/models/' '../lib', '../db'].each do |folder|
	$:.unshift File.join(ROOT, folder)
end

p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting Switchyard Middleware: #{File.basename(__FILE__)}"



$logger = Logger.new('base-api.log', 'w')

$options = Hash.new
$options[:host] = '10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5

class Logs < ActiveRecord::Base
	include Redis::Objects

	## REPLACE  this with the appropriate database.yml
	establish_connection(	:adapter => 'mysql2',
	                       :host=> 'datastore2',
	                       :username=> 'rsyslog',
	                       :password=> 'bigrsyslogpasswordforsure',
	                       :database=> 'rsyslog',)

	self.table_name = 'SystemEvents'


	def self.search(query)
		where("message like ?", "%#{query}%")
	end

	protected



	private

end

class CallGirl < ActiveRecord::Base

	 establish_connection(
	adapter: mysql2  ,
	encoding: utf8    ,
	pool: 5            ,
	username: callgirl  ,
	host: datastore2     ,
	password: githerdunno ,
	url: "mysql2://callgirl:githerdunno@10.0.1.32/callgirl",

	 )



end

class Organization < CallGirl


end



### Hotline db -> main db
ActiveRecord::Base.logger = Logger.new('db.log')
#ActiveRecord::Base.establish_connection(:development)
ActiveRecord::Base.establish_connection(
		:adapter => 'mysql2',
		:database => 'hotline',
		:username => 'hotline',
		:password => 'githerdunnohotline',
		:pool => 5,
		:host => 'datastore2',
		:url =>  "mysql2://hotline:githerdunnohotline@10.0.1.32/hotline")


Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
	Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})
}

$SHM = Redis::List.new('baseapi', :marshal => true)

class HotlineAPI < Sinatra::Base

	def initialize
		p "#{Time.now}:#{self.class}:IP##{__LINE__} Handling request: RESTFUL API: Class #{self.class}" if $DBG
	end
end

class Powersaw < Sinatra::Base
	attr_accessor :user_obj
	set :server, :thin
	set :environment, :development
	#before do ; expires 300, :public, :must_revalidate ;end # before filter use instead of in method, protip

	def initialize
		$logger.info "#{Time.now}:#{self.class}:IP##{__LINE__}: Received request"
	end

	get '/' do
		'PowerSaw API'
	end

	get '/config' do
		$DBG = false
		pp env if $DBG
		#cache_control :public; "cache it"

		#if params.has_key?('gucid')foo
		#'Hey there'
		#  status, response = generate_response(params)
		#  if
		#end
	end

	post '/logs' do
		$DBG = false
		pp env if $DBG
		ret = {}

	end

	post '/check_update' do
		$DBG = false
		pp env if $DBG
		ret = {}
    ret[:body] = 'yay'
	end

	def self.new(*)

		app = Rack::Auth::Digest::MD5.new(super) do |username, password|
			$logger.info "Authentication Request: #{username}:#{password}"
			{'foo'=> 'bar'}[username]

			# @user_obj = User.authenticate(username, password)
		end

		app.realm = "Hotline"
		app.opaque = "eikjalkjalosdfjSecret3pij398323543klhj2lh4tkth4858674"
		app
	end
	end
