#!/usr/bin/env ruby
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'json'
require 'libnotify'

$VERSION = '1.0.0'
$DEBUG = false
$options = {}
$options[:host] = '10.0.1.17'
$options[:db] = 1
$options[:port] = '6379'
$options[:table] = 'system:notifications'
$options[:printstdout] = false
$options[:notify_desktop] = true
$options[:notify_email] = false
$options[:remote_notify_desktop] = false
$options[:notify_log] = false

logger = Logger.new('log/pop.log')

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout:
5) { Redis.new({host: $options[:host], port: $options[:port], db: $options[:db]})}

$MSGQUE = Redis::List.new($options[:table]) #, :marshall => true)
$TITLE = "[Si] SiliconTooling Systems Analysis Framework"
p $TITLE

def send_mail(msg, email=nil)
	`echo #{msg} | /usr/sbin/ssmtp -vvv support@baremetalnetworks.com` if $DEBUG
	unless email.nil?; `echo #{msg} | /usr/sbin/ssmtp -vvv #{email}`; end
end


def notify_desktop(msg) #  , body, duration=20);
	p "#{msg}"
	Libnotify.show(:summary => msg, :body => "[#{$MSGQUE.values.length}]:#{Time.now}: #{msg}", :timeout => 25)
	#system("notify-send #{subject.to_s}")
end

# gem install libnotify #--version 0.8.1
#require 'libnotify'
#Libnotify.show(:summary => msg, :body => msg, :timeout => 25)

#def remote_notify_desktop(host,password, sub, msg);`ssh #{host}\@#{password} | notify-send "#{msg}" "#{sub}" -t 35`;end

while true do
  unless $MSGQUE.nil?
	  begin
    received= $MSGQUE.values.shift
    rec = Marshal.load(received)
    $MSGQUE.delete(received)
    p "#{Time.now}: #{$MSGQUE.values.count} in Stack: Received message: #{rec}" #if $options[:printstdout]
      logger.info "#{Time.now}: #{rec}"
		  notify_desktop(rec)
      send_mail(msg, 'transiencymail@gmail.com)') if $options[:notify_email]
             sleep 5
	  rescue TypeError ;rec = nil ;

	  rescue StandardError => err
			logger.info "#{__LINE__} #{err}"
	  end
  end
end
#
# Kernel.trap("SIGINT"){
#
# }
