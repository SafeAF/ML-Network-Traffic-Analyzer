#!/usr/bin/env ruby -w
require 'json'
require 'mongoid'
require 'bson'
require 'sinatra'
require 'redis-objects'
require 'connection_pool'
#require 'sidekiq'
#require 'sidekiq/web'


#require File.expand_path(File.dirname(__FILE__) + '/libmongols')
#$redis = Redis.current


$options = Hash.new
$options[:host] = '10.0.1.75'# '10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5

Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
  Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})}


$redisLogservTable = 'yard:logserver'
$LOGSERV = Redis::List.new($redisLogservTable, :marshal => true)
# transport to bloodlust
$redisBloodlustConnector = 'yard:connector'
$BLOODCONN = Redis::List.new($redisBloodlustConnector, :marshal => true)
$redisAttritionAuthTable = 'attrition:api:auth'
$AUTHTABLE = Redis::List.new($redisAttritionAuthTable, :marshal => true)


$logger = Logger.new('logserver.log')
$TITLE = 'EMERGENT ATTRITION LOG POSTING INFRASTRUCTURE'
$STATUS = true
#########################################################################
# Main App
#########################################################################
class LogServ < Sinatra::Base
  get '/' do
    "
 <p>######################## ADI ##########################</p>
  <p>#            #{$TITLE}              #</p>
 <p>#######################################################</p>
 <p>##########  Switching LogServer API Server  ############</p>
<p>#######################################################</p>
 <p>#v#{$VERSION} Codename: Rack 'em and stack 'em  !#</p>
 <p>#######################################################</p>
 "
  end

  ### Status should actually check the status of sidekiq preprocessinga nd bl jobs
  ## and return a health value based on it, a lower health value should be used by
  ## clients to downthrottle their pushing logdata to the server to reduce load
  get '/status' do
    if $STATUS
    {status: 'up', version: $VERSION, title: $TITLE, bl: $redisBloodlustConnector, logserv: $redisLogservTable,
     date: Time.now}.to_json
    else
      {status: 'down', version: $VERSION, title: $TITLE, date: Time.now}.to_json
    end

  end


#   # before '/logs' do
#   #   authenticate_client
#   # end
#
#
#
#   end
#
  post "/logs" do # add version to url ie /api/v1/logs

    begin
      @auth = false
      if params[:user] == 'attritiondemo' && params[:pass] == 'afoobasspassword'; @auth=true;end
    #  if @auth
      if $STATUS
    @log = params[:logfile]
    instanceType = params[:instancetype]
    instanceID = params[:instanceid]
    machineID = params[:machineid]
    apiKey = params[:apikey]
    apiuuid = params[:apiuuid] # SecureRandom.uuid(40)

    count = $BLOODCONN.values.count
    $BLOODCONN.push(@log)
    newcount = $BLOODCONN.values.count

   $logger.info "Entities-in-transit queue: #{newcount}"
    $logger.info "changed by #{newcount - count}. Log up, len: #{@log.length}"
    {status: "#{Time.now}: Log uploaded", length: @log.length, date: Time.now}.to_json
    else
      {status: "Failed to upload, Logserv is returning down status", date: Time.now}.to_json
    end

    rescue => err
    $logger.error "Omgz we can haz error: #{err.inspect} :::::: #{err.backtrace}"

      end
    {status: 'up', version: $VERSION, title: $TITLE, bl: $redisBloodlustConnector,         logserv: $redisLogservTable,
     date: Time.now, message: 'Thank you for your submission',
     filesize: @log.size.to_s, backend: newcount.to_s }.to_json
    end



  #
  #
  # get '/halt' do
  #   'Failure'
  #   halt 500
  # end
  # before '/protected/*' do
  #   authenticate!
  # end
  #
  # get '/', :host_name => /^admin\./ do
  #   "Admin Area, Access denied!"
  # end
  # set(:probability) { |value| condition { rand <= value } }
  #
  # get '/win_a_car', :probability => 0.1 do
  #   "You won!"
  # end
  #
  # get '/win_a_car' do
  #   "Sorry, you lost."
  # end
end

p "Warning running as attached service, not as a daemon: using port 4567!"
LogServ.run! if __FILE__ == $0

__END__


@@ layout
<html>
  <head>
    <title>Sinatra + Sidekiq</title>
    <body>
      <%= yield %>
    </body>
</html>

@@ index
  <h1>Sinatra + Sidekiq Example</h1>
  <h2>Failed: <%= @failed %></h2>
  <h2>Processed: <%= @processed %></h2>

  <form method="post" action="/msg">
    <input type="text" name="msg">
    <input type="submit" value="Add Message">
  </form>

  <a href="/">Refresh page</a>

  <h3>Messages</h3>
  <% @messages.each do |msg| %>
    <p><%= msg %></p>
  <% end %>