#!/usr/bin/ruby -w

require 'thin'
require 'syslog'
require 'net-http'
require 'atomic'
require 'pp'
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'activerecord'
require 'connection_pool'

Dir[File.dirname(__FILE__) + '../lib*.rb'].each do |file|
  require File.basename(file, File.extname(file))
end

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
  Redis.new({host: $options[:host], port: $options[:port], db: $options[:db]})}

$SHM = Redis::List.new('system:log', :marshall => true)

class Net::HTTP
  alias_method :old_initialize, :initialize
  def initialize(*args)
    old_initialize(*args)
    @ssl_context = OpenSSL::SSL::SSLContext.new
    @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end
# Thin server to receive posted messages
class LogStruct
  attr_accessor :rawLogAry, :parserStack, :parsedStack, :finLogAry

  def initialize()
    @rawLogAry = Array.new
    @parserStack = Array.new
    @parsedStack = Array.new
    @finLogAry = Array.new
    @iterations = Numeric.new
    @timespan = DateTime.new
  end
end

Thread.new {
  Thin::Server.start('0.0.0.0', 3333, Class.new(Sinatra::Base) {
    get '/logs' do
      ret = {}
      ret[:foo] = 'bar'
      ret[:baz] = 'too'
      ret.to_json

    end

    post '/logs'
    ret = {}
    @logs = JSON.parse(params[:logfile], :symbolize_names => true)

    ret[:foo] = 'success'

  })}

Net::HTTP.get(uri.host, uri.port)
# Redis setup fro messages  receive

#rece







#
# O sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
