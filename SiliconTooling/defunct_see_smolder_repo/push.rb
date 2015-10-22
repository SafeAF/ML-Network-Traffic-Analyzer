#!/usr/bin/env ruby
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'json'
require 'optparse'
require 'pry'
$TITLE = "[Si] SiliconTooling: Clustered Systems Operations Framework -- Notification::Push"
## Add option parsing
$DEBUG = true
$VERSION = '1.0.0'
options = Hash.new

options[:database] = ARGV[5] || '1'
options[:redisport] = ARGV[4] || '6379'
options[:redishost] = ARGV[3] || '10.0.1.17'
options[:table] = ARGV[1] || 'system:notifications'
message = ARGV[0] || ARGF.read

if message.nil?
	raise "Usage: ruby #{__FILE__} <message> <redis host> <redis port> <redis database>"
end

Redis.current = Redis.new(:host => options[:redishost], :driver => :hiredis, :port =>  options[:redisport], :db => options[:database])
$MSGQUE = Redis::List.new(options[:table] , :marshal => true)
# vers = Redis::Value.new('system:pushdotrbVersion')
# oldVers = vers.value $VERSION
# if $VERSION < oldVers
# 	raise "You are using an outdated push.rb, please update!"
# end
# vers.value = $VERSION
#
p "Pushing: #{message.inspect} to Host: #{options[:redishost]}" if $DEBUG

def push(msg)
$MSGQUE << msg
end

push(message)




__END__

# Connection pool is kinda overkill i think
=begin

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
  Redis.new({host   "#{ARGV[0]}"  + " #{ARGV[1]}" +  " -t #{options[:duration]}"
: options[:redishost], port: options[:redisport], db: options[:redistable]})
}
=end


options = {}
opt_parser = OptionParser.new do |opts|
  exec_name = File.basename($PROGRAM_NAME)
  opts.banner = "###### PUSH ######## \n #{$TITLE} \n # Notification Queque Stacklefish::Push\n
  Usage: #{exec_name} <options> <message> <body> \n""   "

  options[:version] = false
  opts.on('-v', '--[no]-verbose', 'Increase detail in output') { |v| options[:verbose] = v if v}

  options[:redishost] = '10.0.1.17'
  opts.on('-h', '--host [REDIS-HOST]', 'Redis database host. Defaults to localhost') { |h|
    options[:redishost] = h }#if h =~ Resolv::IPv4::Regex ? true : false }

  options[:redisport] = '6379'
  opts.on('-P', '--port [REDIS-PORT]', 'Redis database host port'){ |p| options[:redisport] = p if p.is_a?(Fixnum) }

  options[:redispass] = nil
  opts.on('-p', '--password [REDIS-PASSWORD]', 'Redis database password') { |p| options[:redispass] = p || nil }

  options[:duration] = 21
  opts.on('-d', '--duration [SECONDS]', 'Duration in seconds for message'){ |d|
    options[:duration] = d if d.is_a?(Fixnum)}

  options[:redistable] = 1
  opts.on('-t', '--redis-table [REDIS-TABLE]', 'Redis table number, must be a fixnum e.g. 1 or 3'){ |d|
    options[:redistable] = d if d.is_a?(Fixnum)}

  options[:xgui] = false
  opts.on('-x', '--x-windows-notify', 'Use this if you and want notifications sent to X Windows') {|x|
    options[:xgui] = true || false}

  options[:xdesktop] = '127.0.0.1'
  opts.on('-x', '--x-windows-desktop', 'Use this when you and want notifications sent to an X Win desktop') {|x|
    options[:xdesktop] = x }#if h =~ Resolv::IPv4::Regex ? true : false }

  # opts.on('-h', '--help', 'Display the help. Show the available options and usage patterns.') {p opts; exit(1)}
end ; opt_parser.parse!
