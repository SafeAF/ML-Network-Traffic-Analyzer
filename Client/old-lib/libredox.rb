#require 'libem'
#require 'crypt'


	def first_run(options)
		options[:cid] = Digest::SHA1.hexdigest(($$ ^ Time.now.to_i).to_s)
	end

#### INSTANCE FUNCTIONS ####

#	def engage_sniffer(instance)
#		libsniffer = Sniffer.new(instance.pcap_interface,
#								instance.pcap_filter,
#								instance.pcap_location)
#		# restart sniffer if it dies
#			sniffer_thread = Thread.new {
#				libsniffer.sniff #(instance.pcap_interface,
##								instance.pcap_filter,
##								instance.pcap_location)
#			} 
#	end

	def load_instances(options)
		instances = Hash.new

		return if options.nil?
		if FileTest.exists? options[:instances_file]
			instance_file = File.open(options[:instances_file], 'rb+')
			#ciphered = instance_file.read
			
			# FIXME finish error checking
			#begin
			#	decrypted = blowfish.decrypt_string ciphered
			#rescue
#				default_instance = { :gucid => 'default', 
#						:instance_type => 'SSH', 
#						:status => '0', :ban_duration => 6000,
#						:pcap_location => 'pcap.log', 
#						:log_location => 'log.log',
#						:strace_location => 'strace.log' }
#				create_crypted_config(default_instance, blowfish)
#				return default_instance
#			end
#			loaded_i = YAML::load(decrypted)
			loaded_i = YAML::load(instance_file)
			instance_file.close
#			loaded_i = YAML::load(File.open(options[:instances_file], 'r+'))
			if loaded_i.nil?
				#error
				p "ERROR: loaded_i.nil?"
			elsif loaded_i.respond_to?("each")
				p loaded_i
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

	def save_instances(instances, options)
		instances.delete(nil)
		instances.each_key {|instance|
				instances[instance].sniffer_thread = nil
			}
		instance_file = File.open(options[:instances_file], 'w+')
#		File.open(options[:instances_file], 'w+') do |out|
#			YAML.dump(instances, out )
#		end
		yaml_dump = YAML.dump(instances)
#		encrypted = blowfish.encrypt_string yaml_dump
		instance_file.write(yaml_dump)
		instance_file.close
#		end
	end

	def get_config_from_server(instance, options, action)
		return if instance.nil?
		begin	

    	uri = URI.parse('https://' + options[:host] +
					 	':' + options[:port] + "/#{action}/")

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl= true
		http.start() do |http|
			req = Net::HTTP::Get.new(
				"/#{action}?gucid=" + instance.gucid +
				'?cid=' + options[:cid])
			req.basic_auth options[:user], options[:pass]
			response = http.request(req)
			response.body
		end
	
		rescue Exception
			sleep options[:retry] 
			options[:host] = rotate_hosts('sw', options[:host], 
				options[:serv_rotate_min], options[:serv_rotate_max])
			retry
		end
	end	
	
	def rotate_hosts(prefix, raw_host, min, max)
			switches = []
			host = raw_host.slice(/\w+\.\w+$/)
			f = lambda { |num| prefix + num.to_s + '.' + host}
			min.upto(max).each {|x| switches.push(f.call(x))}
			return switches.sort_by {rand}.pop
	end

	def handle_config_parcel(parcel)
		c = Hash.new
		parcel.split(/::/).each do |item|
			item.gsub!(/[\\\"]*/, '')
			key, value = item.split(/==/)
			next if key.nil?
			next if value.nil?
			key.downcase!
			symbol = :"#{key}"
			c[symbol] = value
		end
		return c
	end

	def send_logs_to_server(instance, options)

		return if instance.nil? 
		return if instance.gucid.nil? 
		return if instance.gucid.match(/default/)
#		logfile = instance.get_log(instance.log_location)
	# logfile temporarily changed to nil
	logfile = nil
		#return nil if logfile.nil?
		raw_pcap_logfile = instance.get_pcap_log(instance.pcap_location)

		libem = Libem.new

		pcap_logfile = []
		return if raw_pcap_logfile.nil?
		raw_pcap_logfile.each { |group|
			packet_group = splitify(group, "\n")
			packet_group.each {|pac|
				next if pac.nil?
				features = ""

				headers,payload = splitify(pac, "~~~")
				next if payload.nil?
				if instance.stats_pcap == "true"
					features = libem.prepare_features(payload)
				else
					features = payload
				end
				pcap_logfile.push headers + "~~" + features + "\n" 
				}
			}
		return if pcap_logfile == []
		begin
			uri = URI.parse('https://' + options[:host] + ':' + 
										 options[:port] + '/submit')

			http = Net::HTTP.new(uri.host, uri.port)
		    req = Net::HTTP::Post.new(uri.path)
			http.use_ssl = true
		    req.basic_auth options[:user], options[:pass]
		    req.set_form_data({
				'user' => options[:user],
				'pass' => options[:pass],
#				'instances_installed' => @instances.keys.join('--'),
				'platform' => RUBY_PLATFORM,
				'instance_type' => instance.instance_type, 
				'log_location' => instance.log_location,
				'pcap_location' => instance.pcap_location,
				'strace_location' => instance.strace_location,
				'hostname' => instance.hostname,
				'client_version' => options[:version], 
				'gucid' => instance.gucid,
				'cid' => options[:cid],
				'ban_duration' => instance.ban_duration,
				'deny_file' => options[:deny_file],
				'retry' => options[:retry],
				'delay' => options[:delay],
				'log' => logfile,
				'pcap_log' => pcap_logfile,
				'pcap_filter' => instance.pcap_filter,
				'pcap_interface' => instance.pcap_interface,
				'stats_pcap' => instance.stats_pcap,
				'monitor_pcap' => instance.monitor_pcap,
				'stats_log' => instance.stats_log,
				'monitor_log' => instance.monitor_log,
				'banlist' => parse_deny_file($OPT) } )
			response = http.request(req)
			return response.body
		
		rescue Exception
			sleep options[:retry]
			retry
		end
	end

	def unpackage_post_response(response)
	end

	def parse_deny_file(options)
		hosts_denied = []
		if FileTest.exists? options[:deny_file]
			deny_hosts = File.open(options[:deny_file], 'r')
			if deny_hosts.nil?
				@elogger.fatal(get_time + "(FATAL)" +
					"Error opening hosts.deny file: #{$!}" ) 
				raise "Error opening hosts.deny file: #{$!}" 
			elsif deny_hosts.respond_to?("each")
				deny_hosts.each do |denied|
					next if /^#/ =~ denied
					#if /^ALL:\s+(.*)\s*$/ =~ denied
					# add banlist duration handling
					#m/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\$/;

					if /^\w+:\s+(.*)\s*$/ =~ denied
						$1.chomp!
						hosts_denied.push $1
					end
				end
			end
		else
			### FUTURE: use iptables if file doesnt exist
			raise "Error: deny file does not exist."
		end
		deny_hosts.close
		hosts_denied
	end


# add lamda to switch append and write for add_to and remove_from deny
	def add_to_deny_file(hoststodeny, location)
		if hoststodeny.nil?
			raise "No array of hosts given"
		elsif hoststodeny.respond_to?("each")
			deny_file = File.open(location, 'a+')
			if deny_file
				hoststodeny.each do |host|
					next if host.nil?
					host.chomp!
					next if host !~ /^\d+\.\d+\.\d+\.\d+$/
					deny_file.puts "ALL: " + host 
				end
				deny_file.close
			else
			@elogger.fatal(get_time + "(FATAL)" +
				"Error opening hosts.deny file: #{$!}")
				raise "Error opening hosts.deny file: #{$!}" 
			end
		end
	end

	def ban(to_ban_dirty, options)
#	needs error checking
		return if to_ban_dirty.nil?
		to_ban = clean(to_ban_dirty)

		#fix
		already_banned = parse_deny_file options
		already_banned.collect { |x| x.chomp! }
		already_banned.uniq!

		bans_to_write = to_ban - already_banned
		bans_to_write.uniq!
		add_to_deny_file(bans_to_write, options[:deny_file])

		#@logger.info(get_time + to_ban.to_s)
	end

	def remove_from_deny_file(hoststodeny, location)
		if hoststodeny.nil?
			raise "No array of hosts given"
		elsif hoststodeny.respond_to?("each")
			# change this to append
			deny_file = File.open(location, 'w+')
			if deny_file
				hoststodeny.each do |host|
					next if host.nil?
					host.chomp!
					next if host !~ /^\d+\.\d+\.\d+\.\d+$/
					deny_file.puts "ALL: " + host #if $DEBUG == 0
					#puts "ALL: " + host #if $DEBUG == 1
				end

			else
			@elogger.fatal(get_time + "(FATAL)" +
				"Error opening hosts.deny file: #{$!}")
				raise "Error opening hosts.deny file: #{$!}" 
			end
			deny_file.close
		end
	end

	def unban(to_unban_dirty, options)
		return if to_unban_dirty.nil?
		#needs error checking
		to_unban = clean(to_unban_dirty)
		#fix
		already_banned = parse_deny_file options
		already_banned.collect { |x| x.chomp! }
		already_banned.uniq!
		remove_from_deny_file(already_banned - to_unban, options[:deny_file])
		#@logger.info(get_time + to_unban.to_s)
	end


#### CONFIG RELATED ####

	def load_config
		options = {:config_file => "config.em"}
		if FileTest.exists? options[:config_file]
			config = File.open(options[:config_file], 'rb+')
#			ciphered = config.read

			#FIXME finish error checking
#			begin
#			decrypted = blowfish.decrypt_string ciphered
#			rescue
#				p "failed decrypt"
#				options = {
#					:config_file => 'config.em',
#					:instances_file => 'instances.em',
#					:port => "7000",
#					:host => 'sw1.bmnlabs.com',
#					:user => 'foo',
#					:pass => 'bar',
#					:deny_file => "hosts.small" || system("find / |grep -i hosts.deny"),
#					:error_log => 'error.log',
#					:delay => 10,
#					:retry => 10,
#					:message => "",
#					:cid => nil,
#					:version => nil,
#					:serv_rotate_min => 1,
#					:serv_rotate_max => 1,
#					}
#				return options
#			end
#			options = YAML::load(decrypted)
			options = YAML::load(config)
			config.close
			if options.is_a? Hash
				options
			else
				options = {
					:config_file => 'config.em',
					:instances_file => 'instances.em',
					:port => "7000",
					:host => 'sw1.bmnlabs.com',
					:user => 'foo',
					:pass => 'bar',
					:deny_file => "hosts.small" || system("find / |grep -i hosts.deny"),
					:error_log => 'error.log',
					:delay => 10,
					:retry => 10,
					:message => "",
					:cid => nil,
					:version => nil,
					:serv_rotate_min => 1,
					:serv_rotate_max => 1,
					}
			end
			options
		else
			File.open(options[:config_file], 'w').close
		end
	end

	def save_config(options)
		# TODO: add error checking
#		File.open(options[:config_file], 'w+' ) do |out|
#		YAML.dump(options, out )
		config = File.open(options[:config_file], 'wb+')
		yaml_dump = YAML.dump(options)
#		ciphered = blowfish.encrypt_string yaml_dump
		config.write(yaml_dump)
		config.close
#		end
	end



#### GENERIC FUNCTIONS ####
	def clean(array)
		array.collect { |x| x.chomp! }
		array.collect { |x| x.chomp! }
		array.collect { |x| x.gsub!(/[^\d|\.]/, '') }
		array.uniq!
		array.compact!
		return array
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

	def splitify(str, pat)
		str.split(/#{pat}/)
	end 

	def timebox
		a = Time.now.to_s.split(/ /)
		a[3]
	end



	def array_a_file(location)
		if FileTest.exists? location
			log = File.open(location, 'r')
			if log.nil?
				log.close
				return nil
			elsif log.respond_to?("each")
				logs = []
				log.each {|entry| logs.push(entry)}
				log.close
				return logs
			else
				log.close
				@elogger.warn(get_time + '(WARNING) ' +
					'Error with logfile at #{location}')
				return nil
			end
		else
#			@elogger.warn(get_time + '(WARNING) ' +
#				'Error file #{location} does not exist.')
			return nil
		end
	end


#	def create_key
#		unless File.exists? "/etc/emergence"
#			Dir::mkdir "/etc/emergence"
#		end
#		keyfile = File.open("/etc/emergence/key", "w+")
#		keyfile.puts Digest::SHA1.hexdigest(($$ ^ Time.now.to_i).to_s)
#		keyfile.close
#		File.chmod(0400, "/etc/emergence/key")

#		#write config.em
#		file = File.open("config.em", 'wb+')
#		ciphered = blowfish.encrypt_string "--- \n:delay: 10\n:pass: bar\n:port: \"7000\"\n:retry: 10\n:message: \"\"\n:host: sw1.bmnlabs.com\n:cid: \n:user: foo\n:serv_rotate_min: 1\n:deny_file: hosts.small\n:serv_rotate_max: 1\n:config_file: config.em\n:version: \n:error_log: error.log\n:instances_file: instances.em\n"
#		file.write(ciphered)
#		file.close

#		#write instances.em
#		file = File.open("instances.em", 'wb+')
#		ciphered = blowfish.encrypt_string "--- 
#default: !ruby/object:Instance 
#  ban_duration: 
#  gucid: default
#  instance_type: 
#  log_location: 
#  message: 
#  pcap_filter: 
#  pcap_interface: 
#  pcap_location: 
#  pcap_port: 
#  pcap_thread_flag: 0
#  status: 
#  strace_location: 
#"
#		file.write(ciphered)
#		file.close
#	end


