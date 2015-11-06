=begin
##################################################################
#### ADAPTIVE DEFENSE INFRASTRUCTURE -- ADI v0.2.0 10-23-15   ####
#### SWITCHDEMO  MIDDLEWARE                                   ####
#### Copyright (C) 2010-2015 BareMetal Networks Corporation   ####
##################################################################

###############################################################################
#### Switchyard is the API of Emergence and the only component that is exposed
#### to the internet, client daemons connect and upload logfiles and download
#### configurations and ban lists
###############################################################################
=end

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')
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
require 'ruby-fann'

#### Installation
## apt-get install libmyslclient18 libmysqlclient18-dev
## Gem install mysql2
## gem install hiredis

ROOT = File.join(File.dirname(__FILE__), '..')

['../app/models/' '../lib', '../db', 'lib/*'].each do |folder|
	$:.unshift File.join(ROOT, folder)
end

p "######################## ADI ##########################"
p "#          ADAPTIVE DEFENSE INFRASTRUCTURE            #"
p "#######################################################"
p "##########  SwitchDEMO RESTful API Server  ############"
p "#######################################################"
p "#v#{$VERSION} Codename:Learn You a Ruby For Very Good!#"
p "#######################################################"

p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting Switchyard Middleware: #{File.basename(__FILE__)}"
$logger = Logger.new('switchyard.log', 'w+')

$options = Hash.new
$options[:host] = '10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5


$TITLE = 'Emergence'



Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
  Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})
}

$SHM = Redis::List.new('e:switchyard', :marshal => true)

## 700 is switchyard return code space




begin
	### Switchyard is the protected class
	class DemoAPI < Sinatra::Base
		attr_accessor :user_obj
		configure do
		set :server, :thin
		set :port, 3000
		set :environment, :production
		end
		#before do ; expires 300, :public, :must_revalidate ;end # before filter use instead of in method, protip

		def initialize
			$logger.info "#{Time.now}:#{self.class}:IP##{__LINE__}: Received request"
		end

		get '/' do
			p 'Emergence API'
			$logger.info "Got request"
		end

		post '/demo' do
			p 'Posted' + "#{params[:pcap_log]}"

		#	p request

		end

		get '/config' do
			$DBG = false
			pp env if $DBG
			#cache_control :public; "cache it"
			ret = {}
			ret[:body] = 'config/ route'
			#sw = SwitchyardAPI.new
			#ret[:body] = sw.get_config(params, @user_obj)

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
		#	@sw = SwitchyardAPI.new
		#	ret[:body] = sw.handle_log_submit(request)
			ret[:body] = 'logs/ submit'
		end



	end

rescue => err
	pp err.inspect
end



__END__

