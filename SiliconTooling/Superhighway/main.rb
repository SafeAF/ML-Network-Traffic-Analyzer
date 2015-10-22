#!/usr/bin/env ruby
require 'json'
require 'optparse'
require 'readline'
require 'highline'
require 'net/ssh'
#require 'fuzzy_match'
require 'redis'
require 'rye'

$PROGRAM_NAME = '[+] Silicon Tooling -> SuperHighway Module [+]'
$VERSION = '0.1.0'
###########################################################################################
# Author: SJK, Senior Developer, BareMetalNetworks.com                                    #
# First week of July 2015                                                                 #
##### Future Features #####################################################################
## Populate hosts hostname by calling each ip and running hostname during the setup       #
## Have both batch and single host command issue                                          #
## Write a parser/lexxer for builtins                                                     #
## History support -- redis                                                               #
## Refactor Node into Node                                                                #
## Dispatch table - builtin commands IMS> batch <command>  IMS> host :staged0 <command>   #
## Buildout options table                                                                 #
## Create another class to Manage those nodes?                                            #
## Output to a file or stuff in a database options -- redis                               #
## Batch command execution and cluster management REPL and plain vanilla CLI toolkit      #
## Redis backed store of hostname/node info plus node statistics & command issue returns  #
## Also redis backed store for fuzzymatch future.                                         #
###########################################################################################
options = {}
opt_parser = OptionParser.new do |opts|
  exec_name = File.basename($PROGRAM_NAME)
  opts.banner = "###### Silicon Tooling - SuperHighway IMS ######## \n # BareMetal's Infrastructure Management Console\n
# GNU Readline supported Ctrl-* and Alt-* emacs keybindings available\n
  Usage: #{exec_name} <options> \n""   "

  options[:version] = false
  opts.on('-v', '--[no]-verbose', 'Increase detail in output') { |v| options[:verbose] = v if v}

  options[:logfile] = nil
  opts.on('-l', '--logfile [FILE]', 'Write output to a file') { |f| options[:logfile] = f || false }

  options[:username] = nil
  opts.on('-u', '--username [REDIS-USER]', 'Redis database username') { |u| options[:username] = u || nil}

  options[:redishost] = '127.0.0.1'
  opts.on('-h', '--host [REDIS-HOST]', 'Redis database host. Defaults to localhost') { |h|
    options[:redishost] = h } #if h =~ Resolv::IPv4::Regex ? true : false }

  options[:redisport] = '6379'
  opts.on('-P', '--port [REDIS-PORT]', 'Redis database host port'){ |p| options[:redisport] = p if p.is_a?(Fixnum) }

  options[:redispass] = nil
  opts.on('-p', '--password [REDIS-PASSWORD]', 'Redis database password') { |p| options[:redispass] = p || nil }

  options[:redistable] = 1
  opts.on('-t', '--redis-table [REDIS-TABLE]', 'Redis table number, must be a fixnum e.g. 1 or 3'){ |d|
    options[:redisdb] = d if d.is_a?(Fixnum)}

  options[:xgui] = false
  opts.on('-x', '--x-windows-notify', 'Use this if you and want notifications sent to X Windows') {|x|
    options[:xgui] = true || false}

  opts.on('-h', '--help', 'Display the help. Show the available options and usage patterns.') {p opts; exit(1)}


end ; opt_parser.parse!

module SuperCluster
#	include Redis::Objects
	attr_accessor :nodes, :hosts, :appips, :devips, :powerplantips, :datastoreips, :managerips, :allips

	def initialize
    @@appips = %w{10.0.1.23 10.0.1.14 10.0.1.27 10.0.1.28}
    @@devips = %w{10.0.1.16 10.0.1.10 10.0.1.38 10.0.1.21 10.0.1.22}
    @@powerplantips = %w{10.0.1.50}
    @@datastoreips = %w{10.0.1.7 10.0.1.13 10.0.1.19 10.0.1.39 10.0.1.32 10.0.1.17 10.0.1.34}
    @@managerips = %w{10.0.1.200 10.0.1.201 10.0.1.30}
    @@allips = @@appips, @@devips, @@powerplantips, @@datastoreips, @@managerips

    #SRVLIST = Redis::List.new('Nodes') #:marshall => true
		@boxes = []
    srvlist =  @@allips
		srvlist.each {|srv| @boxes.push(Rye::Box.new(srv, :safe => false)); @boxes}
		p @boxes if $DBG
		@nodes = Rye::Set.new
		@nodes.parallel = true
		@boxes.each {|srv|@nodes.add_boxes srv}
		p @nodes if $DBG
	end

end

## History match/Command completion
## Fuzzymatch.new(['foo', 'bar', 'baz']).find("far")
#
# setup_redis = lambda { redis = Redis.new({:host => options[:redishost], :port => options[:redisport]})
#                           redis.select(options[:redisdb]) ; redis}
# $redis = setup_redis.call

#redi.key?(:node_ips)

all_srv = Array.new
$redis[hwy:allServers]
all_srv = %w{10.0.1.200 10.0.1.32 10.0.1.27 10.0.1.10 10.0.1.7 10.0.1.19 10.0.1.20 10.0.1.21 10.0.1.22 10.0.1.28}

srvs = {:datastore0 => '10.0.1.18', :datastore2 => '10.0.1.32', :app2 => '10.0.1.27', :app3 => '10.0.1.28', :app1 => "10
.0..23"}




$XGUI = ARGV.shift || false
#running on xwindows system opt and non xwindows but forward to xwindows opt
# extended prompt yes||No
$EXTENDPROMPT = true

# if hosts && File.exists?(hosts)
#   main(hosts)
#
#   # TODO finish this
# #elsif #parser
#  # `git clone https://github.com/baremetalnetworks/clusterforge`
#
# else
#   STDERR.puts "Error: Couldn't find an infrastructure.hosts YAML file, creating one now in /tmp from /etc/hosts"
#   `touch /tmp/hosts.json`
#   p 'restart the REPL'
#   #exit 1
# end

$stack = Array.new

def lexxsexx(expr, opsTable)
  tokens = expr.split(" ")
  tokens.each do |tok|
    type = tok =~ /\A\w+\Z/ ? :tok : nil
    opsTable[type || tok][tok]
  end
end

  class Node
    attr_accessor :host, :user, :password, :running, :results, :hostname, :physHost

    def initialize(host, user, password)
      @host = host
      @user = user
      @password = password
      @results = Array.new
      @running = false
      #@key = key
    end
    def shexec(command)
      Net::SSH.start(@host, @user, :password => @password) do |ssh|
        ssh.open_channel do |channel|
          channel.exec command do |channel, success|
            raise "Could not execute #{command}" unless success
            channel.on_data do |channel, data|
              return data

            end
          end
        end
      end
    end
  end

$history = Array.new # for history cache



def main(srvs)
  command = nil
  cmd_count = 0
  conns = Array.new

  # Construct node objects, keys are hostnames and results is array
  srvs.each {|srv| conns.push(Node.new(srv, 'vishnu', 'password' ))}
  ## store hostnames in redis with a 5min expiry
  conns.each {|conn| node.hostname = node.shexec('hostname'); node.running = true  }

  # Function issuers, threaded and non-threaded
  threadedcmd = lambda { |conn| Thread.new { conn.results.push(conn.shexec(command)) }}
  #threadedcmd = lambda { |conn| Thread.new { p "### Host #{conn.host} ###\n" + conn.shexec(command) }}
  issuecmd = lambda { |conn|  p "### Host #{conn.host} ###\n" + conn.shexec(command) }


  begin
    result = []
    while command != ('exit' || 'quit')
      command = Readline.readline("#{Time.now}-#{cmd_count.to_s}-IMS> ")
      break if command.nil?
      cmd_count += 1
      $history.push command if $history.include?(command)
      `notify-send "Issuing command: [#{command}] to host(s) [#{host.keys}]"` if $XGUI
      begin
        conns.each {|conn| threadedcmd.call(conn) if conn.running}

      rescue => err
        pp "[SSH Issuer] Error: #{err.inspect} #{err.backtrace} on #{__FILE__} on line #{__LINE__}"
        next
      end
      p conn.each { |conn| p conn.result}
    end

  rescue => err
    pp "[Main] Error: #{err.inspect} #{err.backtrace} on #{__FILE__} on line #{__LINE__}"
    retry
  end
end

main(all_srv)
