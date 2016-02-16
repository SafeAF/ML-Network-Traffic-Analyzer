require 'yaml'
require 'pcaplet'

options = {:instances_file => "instances.em",
			:retry => 2}

class Sniffer
	def initialize(interface, filter_string, pcap_location)
		@interface = interface
		@filter_string = filter_string
		@pcap_location = pcap_location
		@sniff_config = ""
	end

def sniff

	# worry about privelege escalation from user->root via config file
	sniff_config = '-s 1500 -i ' + "#{@interface}"
	network = Pcaplet.new(sniff_config)
	filter = Pcap::Filter.new(@filter_string, network.capture)
	network.add_filter(filter)
	# store as yaml?
	pcapfile = File.open(@pcap_location, 'w') # old mode was r+
	i = 0
	p "[SNIFFER] - " + timebox + " - " + "Engaged on " + @interface + " " + @filter_string if $DEBUG

	# needs sig trap & handling to save file upon kill
	trap("INT") do
		p "Stopping sniffer..."
		pcapfile.flush
		pcapfile.close
		exit 
	end
	# changed string_to_hex(payload) to use addon to_hex
	for pac in network
   		next if pac.nil?
		if filter =~ pac
			# set up to handle tcp or udp
			next if pac.tcp_data.nil?
			a = Time.now.to_s.split(/ /)
#			pcapfile.flock File::LOCK_EX
			pcapfile.print a[3] + "::" 
				pcapfile.print pac.ip_src.to_s + "::" + pac.ip_dst.to_s +
				"::" + pac.tcp_sport.to_s + "::" + 
				pac.tcp_dport.to_s + "~~~" + pac.tcp_data.to_hex + "\n" 
			pcapfile.flush
			end
   			i += 1
		end
	end
end
# replace the above with this

#	def sniff
#		# worry about privelege escalation from user->root via config file
#		@sniff_config = '-s 1500 -i ' + "#{@interface}"
#		network = Pcaplet.new(@sniff_config)
#		filter = Pcap::Filter.new(@filter_string, network.capture)
#		network.add_filter(filter)
#		# store as yaml?
#		pcapfile = File.open(@pcap_location, 'r+')
#		i = 0
#		p "[SNIFFER] - " + timebox + " - " + "Engaged on " + 
#			@filter_string if $DEBUG
#		# changed string_to_hex(payload) to use addon to_hex
#		for p in network
#	   		next if p.nil?
#			if filter =~ p
#				# set up to handle tcp or udp
#				a = Time.now.to_s.split(/ /)
#				pcapfile.print "1".to_s + "::" + pcapfile.print a[3] + "::" +
#				pcapfile.print p.ip_dst.to_s + "::" + p.ip_src.to_s + 
#				"::" + p.tcp_dport.to_s + "::" + 
#				p.tcp_sport.to_s + "~~~" + p.tcp_data.to_hex + "===" 
#			end
#	   		i += 1
#  		 # this number may need optimization
##   		if i > 100
##			pcapfile.close
##			p "[SNIFFER] - " + timebox + " - " + " Saved pcap file" if $DEBUG
##			i = 0
##			pcapfile = File.open(@pcap_location, 'rb+')
##			end
#		end
#	end
#end

	def timebox
		a = Time.now.to_s.split(/ /)
		a[3]
	end

	class String
		def to_hex
			return if self.nil?
			ret = ""
			for i in (0..self.length)
				unless self[i].nil?
					ret += self[i].to_s(16)
				end
			end
			ret
		end
	end

	def engage_sniffer(instance)
		libsniffer = Sniffer.new(instance["pcap_interface"], 
								instance["pcap_filter"],
								instance["pcap_location"])
		# restart sniffer if it dies
			sniffer_thread = Thread.new {
				libsniffer.sniff
			}
	end

	def disengage_sniffer(instance)
		return if instance['sniffer_thread'].nil?
		p "[SNIFFER] - " + timebox + " - Disengaged from #{instance['pcap_interface']}"
		instance["sniffer_thread"].exit
		instance["sniffer_thread"] = nil
	end

	def load_instances(options)
		instances = Hash.new

		return if options.nil?
		if FileTest.exists? options[:instances_file]
			instance_file = File.open(options[:instances_file], 'rb+')
			loaded_i = YAML::load(instance_file)
			instance_file.close
			if loaded_i.nil?
				#error
				p "ERROR: loaded_i.nil?"
			elsif loaded_i.respond_to?("each")
#				p loaded_i
				loaded_i.each_key do |x|
					#loaded_i[x].sniffer_thread = nil
					instances[x] = loaded_i[x]
				end

			else
				# error
				p "### INSTANCE NOT FOUND ###"
				
			end
			instances
		else
			loaded_i = File.open(options[:instances_file], 'w')
			if not loaded_i.nil?
				loaded_i.close
				loaded_i = YAML::load(File.open(options[:instances_file], 'r+'))
				if loaded_i.respond_to?("each")
					loaded_i.each_key do |x|
						instances[x] = loaded_i[x]
					end
				else
					# error
				end
			else
				# error 'unable to create file
				p "unable to create file"
			end
		end
		instances
	end

	def reload_instances(options, instances)
		reloaded_instances = load_instances(options)
		instances.each {|instance|
			next if instance['gucid'] == 'default' or
				reloaded_instances[instance['gucid']].nil?
			matched_instance = reloaded_instances[instance['gucid']].ivars
			# update changed values
			unless matched_instance['pcap_interface'] == 
					instance['pcap_interface']
				disengage_sniffer instance
				instance['pcap_interface'] = 
					matched_instance['pcap_interface']
				instance['pcap_thread_flag'] = 0
			end
			unless matched_instance['monitor_pcap'] == 
					instance['monitor_pcap']
				instance['monitor_pcap'] = 
					matched_instance['monitor_pcap']
			end
			unless matched_instance['pcap_filter'] == 
					instance['pcap_filter']
				disengage_sniffer instance
				instance['pcap_filter'] = matched_instance['pcap_filter']
				instance['pcap_thread_flag'] = 0
			end
			unless matched_instance['pcap_location'] == 
					instance['pcap_location']
				disengage_sniffer instance
				instance['pcap_location'] = 
					matched_instance['pcap_location']
				instance['pcap_thread_flag'] = 0
			end
			}
	end

# load instances and strip default instance
loaded_instances = load_instances(options)
instances = []
loaded_instances.each {|x|
	next if x[1].ivars['gucid'] == 'default'
	x[1].ivars['pcap_thread_flag'] = 0
	instances.push  x[1].ivars
	}

$DEBUG = 1
loop {
	instances.each {|instance|
		unless instance["pcap_interface"].nil? or 
			instance["pcap_filter"].nil? or 
			instance["pcap_location"].nil? or
			instance["gucid"] == 'default'
			if(instance["pcap_thread_flag"].to_i == 0 &&
				instance["monitor_pcap"] == "true")
				# FIXME doesnt check to see if sniffer is actually engaged
				instance["sniffer_thread"] = engage_sniffer(instance)
				instance["pcap_thread_flag"] = 1
			elsif(instance["pcap_thread_flag"].to_i == 1 &&
				instance["monitor_pcap"] == "false")
				disengage_sniffer instance
				instance["pcap_thread_flag"] = 0
			end
		end
		}
	reload_instances options, instances
	sleep options[:retry]
}
