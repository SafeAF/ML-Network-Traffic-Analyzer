#!/usr/bin/ruby
### BareMetalNetworks Corp 2015 (C)
### SJK
### Development collaboration functionality plus operations components for
###  cluster and server monitoring
###
###  This is the aggregation daemon, there are
###  corresponding client side daemons for monitoring additional servers or
###  clusters. Functionality includes memory hdd and cpu load monitoring, and
###  network connection monitoring. Heartbeat monitoring with user defined
###  service checks are planned for.

## Use redis instead of drb or http

require 'rubygems'
require 'uri'
require 'timeout'
require 'thin'
require 'thread'
require 'sinatra'
require 'net/https'
require 'json'
require 'mysql'
require 'ipaddr'

# read_config_file or use commandline options given or fail
$sqlUser = 'silicontooling'
$sqlPass = 'siliconpassword'
$dbName = 'silicontooling'
$dbIP = '10.0.0.32'

$httpServeStats = 0 || ARGV[0]

$stats = {}
$statsnum = 0

def start_thin
	Thread.new {
	Thin::Server.start('0.0.0.0', 3500, Class.new(Sinatra::Base) {
		get '/statsnum' do
			"#{$statsnum.swap(0)}"
		end
	  get '/stats' do
					"#{$stats}"
		end
	}, 3500, signals: false)
}
sleep 2
end


## TODO replace this with active recordf
# Insert into the database
def with_db
  dbh = Mysql.real_connect($dbIP, $sqlUser, $sqlPass, $dbName)

  begin
    yield dbh
  ensure
    dbh.close
  end
end


def retrieve_peerlist(ip)
	begin
			uri = URI.parse('http://' + ip + ':3001/')
			http = Net::HTTP.new(uri.host, uri.port)
			result = http.get 'http://' + ip + '/flush_stats'
			return JSON.parse(result.body)

	end
rescue => err
	p "#{Time.now}: Error in function: retrieve_peerlist. #{err} error was detected! Details: #{err.inspect}"
	p "#{Time.now}: ++++++Backtrace++++++"
	p "#{err.backtrace}"
	p "#{Time.now}: ++++End Backtrace++++"
	sleep 10
	retry
end


def parse_stats(rawStats)
  p "#{rawStats}"
end

def insert_into_db(parsedStats)
  queryCount = 0
  start = Time.now
  p "#{Time.now}: Beginning upserts to database"
  parsedStats.each do |t|
    $dbresult = ''
    with_db do |db|
      ip = IPAddr.new(t['ip']).to_i
      ## TODO -- Construct Query and db schema
      query = ""
      queryCount += 1
      $dbResult = db.query(query)
    end
  end

  finish = Time.now
  total = finish - start
  p "#{Time.now}: #{queryCount} upserts to #{$dbName} completed in #{total} seconds"
  queryCount
end

begin
  while true
    #rawStats.clear
		if $httpServeStats; start_thin; end
    rawStats = {}
    parsedStats = {}
    ips_to_scrape.each do |ip|
      rawStats= retrieve_stats(ip)
      if rawStats.nil? or rawStats == 0
        p "#{Time.now}: WARNING: Didn't retrieve any fresh stats from #{ip}"
      else
        parsedStats = parse_stats(rawStats)
        p "#{Time.now}: Retrieved #{rawStats.length} total stats from address #{ip}"
      end
    end
    queryCount = insert_into_db(parsedStats)
    p "----------------------------------------------------------"
    sleep 300
  end
rescue =>   err
  p "#{Time.now}: Error - #{err.inspect}"
  p "#{Time.now}: ++++++Backtrace++++++"
  p "#{err.backtrace}"
  p "#{Time.now}: ++++End Backtrace++++"
  sleep 300
  retry
end
