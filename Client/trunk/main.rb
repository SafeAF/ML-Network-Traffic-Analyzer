#!/usr/bin/ruby -w
require 'digest/sha1'
require 'uri'
require 'socket'
require 'net/https'
require 'logger'
require 'yaml'
require_relative 'libredox'
require_relative 'libinit'
require_relative 'libinstance'
require_relative 'libem'

# apt-get install libinline-ruby libpcap-ruby
# gem install crypt

### TODO list ###
# unique install script w/ username and password hash on install
# encrypt config file
# iptables support
# implement Class: Tempfile secure temporary files, 'ensure close'
# and make threadsafe
# find where "nil" instance is added

# add dummy stats features

# Disable annoying warning message
# warning: peer certificate won't be verified in this SSL session
class Net::HTTP
  alias_method :old_initialize, :initialize
  def initialize(*args)
    old_initialize(*args)
    @ssl_context = OpenSSL::SSL::SSLContext.new
    @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end

$DEBUG = 0
$DEBUG = ARGV[0].to_i


default_instance, loaded_instances, $ROOT, $OPT = init
first_run($OPT) if $OPT[:cid].nil?
man = InstanceManager.new


man.instance_manager(default_instance, $OPT )
loaded_instances.each {|x|
	man.instance_manager({:gucid => x[0]}, $OPT )
	}

## Need a interrupt handler that saves conf & instance files
#trap("INT") do finish(man) end
#def finish(man) 
#	p "Cleaning up..."
#	save_config $OPT
#	save_instances man.instances, $OPT
#	exit
#end


$OPT[:version] = '0.7.1'
$OPT[:date] = '09-02-11'


begin
trap("INT") do finish(man) end
def finish(man) 
	p "Cleaning up..."
	save_config $OPT
	save_instances man.instances, $OPT
	exit!
end
loop {
	man.instances.each_key do |i|
		next if i.nil?
		next if man.instances[i].nil?
		next if man.instances[i].gucid.nil?

#		unless man.instances[i].pcap_interface.nil? or 
#			man.instances[i].pcap_filter.nil? or 
#			man.instances[i].pcap_location.nil? or
#			i == 'default'
#			if(man.instances[i].pcap_thread_flag.to_i == 0 &&
#				man.instances[i].monitor_pcap == "true")
#				# FIXME doesnt check to see if sniffer is actually engaged
#				man.instances[i].sniffer_thread = engage_sniffer(man.instances[i])
#				man.instances[i].pcap_thread_flag = 1
#			elsif(man.instances[i].pcap_thread_flag.to_i == 1 &&
#				man.instances[i].monitor_pcap == "false")
#				p "[SNIFFER] - " + timebox + " - Disengaged"
#				man.instances[i].sniffer_thread.exit
#				man.instances[i].pcap_thread_flag = 0
#			end
#		end

		parcel = get_config_from_server(man.instances[i], $OPT,"retrieve")
		updates = handle_config_parcel(parcel)
		man.instance_manager(updates, $OPT)
#p updates
		response = send_logs_to_server(man.instances[i], $OPT)
		if not response.nil?
			to_ban = unpackage_post_response(response)
			ban(to_ban, $OPT)
		end
#		man.instances[i].clean_log(man.instances[i].pcap_location)

		p 'DEBUG: ' + man.instances[i].gucid.to_s + " " + man.instances[i].pcap_interface.to_s #+ man.instances[i].message
		save_config $OPT
		save_instances man.instances, $OPT
	end
}
ensure
	save_config $OPT
	save_instances man.instances, $OPT
	exit
end


