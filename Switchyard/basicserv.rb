
BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')

$VERSION = '0.7.0'
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

#### TODO
# message pack
# api key/pw

#### Installation
## apt-get install libmyslclient18 libmysqlclient18-dev
## Gem install mysql2
## gem install hiredis
$REDISTABLE = 'attrition:queque'
ROOT = File.join(File.dirname(__FILE__), '..')
['../app/models/' '../lib', '../db', 'lib/*'].each do |folder|
  $:.unshift File.join(ROOT, folder)
end
p "######################## ADI ##########################"
p "#          ADAPTIVE DEFENSE INFRASTRUCTURE            #"
p "#######################################################"
p "##########  Switchyard RESTful API Server  ############"
p "#######################################################"
p "#v#{$VERSION} Codename: Ruby Has the Great Rack!         #"
p "#######################################################"
p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting Switchyard Demo Middleware: #{File.basename(__FILE__)}"

$logger = Logger.new('switchyard.log', 'w')
$REDISTABLE = 'attrition:queque'
$options = Hash.new
$options[:host] = 'localhost'# '10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5

Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
  Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})}
$QUEQUE = Redis::List.new($REDISTABLE, :marshall => true)
$TITLE = 'SwitchYard DemoServ'



begin
  ### Switchyard is the protected class
  class Switchyard < Sinatra::Base
    attr_accessor :user_obj
    set :server, :thin
    set :environment, :production
    #before do ; expires 300, :public, :must_revalidate ;end # before filter use instead of in method, protip

    def initialize
      $logger.info "#{Time.now}:#{self.class}:IP##{__LINE__}: Received request"
    end

    get '/' do
      "Attrition SwitchYard Server API v#{$VERSION}"
    end


   get '/demo' do
      query = request.query

      if query
        pcap = query[:pcap_log] if query[:pcap_log]
        #pcap_inputs = pcap.split("\n")
        pcap_inputs = JSON.parse(pcap) ## look into using message pack ehre
        logs = query[:log] if query[:log]

        pcap_inputs.each do |packet|
          header, features = packet.split("~~")
          features_str = features.to_s
          red = Hash.new
          red[:time], red[:src], red[:dst], red[:sport], red[:dport] = header.split('::')
          red[:features] = features_str
          $logger.info "#{Time.now} - Pushing packet SRC:#{red[:src]}:#{red[:sport]}
DST:#{red[:dst]}:#{red[:dport]}"
          $QUEQUE.push(red)
        end
      end

    get '/config' do
      $DBG = false
      pp env if $DBG
      #cache_control :public; "cache it"
      ret = {}
      sw = SwitchyardAPI.new
      ret[:body] = sw.get_config(params, @user_obj)
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
      sw = SwitchyardAPI.new
      ret[:body] = sw.handle_log_submit(request)
    end


    def self.new(*)

      app = Rack::Auth::Digest::MD5.new(super) do |username, password|
        $logger.info "Authentication Request: #{username}:#{password}"
        {'foo'=> 'bar'}[username]

        # @user_obj = User.authenticate(username, password)
      end

      app.realm = "Emergence"
      app.opaque = "eikjalkjalosdfjSecret3pij398323543klhj2lh4tkth4858674"
      app
    end

  end


rescue => err
  pp err.inspect
end

