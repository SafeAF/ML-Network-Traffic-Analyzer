#!/usr/bin/env ruby -w
require 'json'
require 'mongoid'
require 'bson'
#require 'sinatra'
require 'redis-objects'
require 'connection_pool'

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


trap("INT") {  exit }
Readline.completion_append_character = " "
Readline.completion_proc = Proc.new do |str|
  Dir[str+'*'].grep(/^#{Regexp.escape(str)}/)
end

while line = Readline.readline('ATLAS> ', true)
  case line
    when /^(redis|bloodlust|logs$/
  end

  break if line.nil? || line == 'quit'
  Readline::HISTORY.push(line)
end


begin
p "--LogPreprocess Bloodlust Queque------------------------------------------------------"
p $BLOODCONN.values
p "--------------------------------------------------------"
count = $BLOODCONN.values.count
#$BLOODCONN.push(@log)
 # $BLOODCONN.clear
newcount = $BLOODCONN.values.count

# $logger.info "Entities-in-transit queue: #{newcount}"
# $logger.info "changed by #{newcount - count}. Log up, len: #{@log.length}"
# {status: "#{Time.now}: Log uploaded", length: @log.length, date: Time.now}.to_json


rescue => err
$logger.error "Omgz we can haz error: #{err.inspect} :::::: #{err.backtrace}"

end

# Get rid of space and quotes as word delimiters in order to read the full line
# Readline.basic_word_break_characters = "\t\n`><=;|&{("
# Readline.completion_proc = proc {|input|
#   begin
#     case input
#       when /^\s*(method1)\s*(['"]?)(.*)$/
#         meth, quote = $1, $2
#         %w{some args to autocomplete}.grep(/^#{$3}/).map {|e| "#{meth} #{quote}" + e}
#       when /^\s*(method2)\s*(['"]?)(.*)$/
#         meth, quote = $1, $2
#         %w{more args to autocomplete}.grep(/^#{$3}/).map {|e| "#{meth} #{quote}" + e}
#       else
#         # Default to irb's default autocompletion
#         IRB::InputCompletor::CompletionProc.call(input)
#     end
#       # irb doesn't handle failed completions nicely
#   rescue Exception
#     IRB::InputCompletor::CompletionProc.call(input)
#   end