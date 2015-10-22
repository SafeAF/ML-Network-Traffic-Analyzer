
#!/usr/bin/ruby
### BareMetalNetworks Corp 2015 (C)
### SJK
### SiliconTooling Node Daemon
### Development collaboration functionality plus operations components for
###  cluster and server monitoring
###
###  This is the clientside component of the daemon for monitoring nodes.
###  Functionality includes memory hdd and cpu load monitoring, and
###  network connection monitoring. Heartbeat monitoring with user defined
###  service checks are planned for.
require 'rubygems'
require 'uri'
require 'timeout'
require 'thin'
require 'thread'
require 'sinatra'
require 'net/https'
require 'json'
require 'drb'
require 'socket'

#integrate into si

$stats = Hash.new ## Datastructure we are going to share with aggregator

class HostStat


	#Get ip -- contrary to appearance it doesnt make an outbound conn
def get_ip
	ip = UDPSocket.open {|s| s.connect("64.233.187.99",1); s.addr.last}

end

	def get_load
	loads = `uptime | awk {'print $10 $11 $12'}`.chomp.split(',')
end

def get_mem
	mem = Hash.new                             13
	sysMem =  `free -m | tail -n 3 | head -1| awk {'print $2,$3,$4,$5,$6,$7'}`
  mem[:total], mem[:used], mem[:free], mem[:shared], mem[:buffers],
		  mem[:cached]  = sysMem.chomp.split(" ")

	sysBuff = `free -m | tail -n 2 | head -1 | awk {'print $3,$4,$5,$6,$7'}`
	mem[:pmbuff], mem[:pmcache] = sysBuff.chomp.split(" ")
  mem      # include swappy at some point probably
end

def get_disk
	f = `df -h | sed -n '1!p' |awk {'print $1 $2 $3 $4'}`
	disk = Hash.new
	disk[:fs], disk[:size], disk[:used], disk[:avail] = f.chomp.split(" ")
	disk
end

def get_net
	nt = `netstat -tanp | sed -n '1!p' | awk {'print $1 $2 $3 $4 $5 $5 $6'}`
  net = nt.chomp.split(" ")
end

end

## screw it lets just stuff it straight in a db, after all why not?
## but we are going to use active record, we arent barbarians!


# Main
begin
  while true
   loads =  get_load
   mems = get_mem
    get_disk
    get_net
		sleep 10
  end

rescue => error
  p "ERROR: In #{__FILE} on line #{__LINE} - #{error.inspect}"
  p "Print me to a logfile someday. No one can see my errors because i am a daemon!"
end





# set_trace_func proc { |event, file, line, id, binding, classname|
#  printf "%8s app1: %-2d %10s %8s\n", event, file, line, id, classname
# }


