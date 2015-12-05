########## Libinit.bmn.rb

def init

## Configuration handling
#load_config

#save_config

#root should be set by config file
	root = "."


#options = {
#:config_file => 'config.em',
#:instances_file => 'instances.em',
#:port => "7000",
#:host => 'sw1.bmnlabs.com',
#:user => 'foo',
#:pass => 'bar',
#:deny_file => "hosts.small" || system("find / |grep -i hosts.deny"),
#:error_log => 'error.log',
#:delay => 10,
#:retry => 10,
#:message => "",
#:cid => nil,
#:version => nil,
#:serv_rotate_min => 1,
#:serv_rotate_max => 1,
#}


# handle encryption init
#keyfile = File.open("/etc/emergence/key", "r")
#options = {:key => keyfile.gets}
#keyfile.close
#blowfish = Crypt::Blowfish.new(options[:key])

# load config here
	options = load_config
	instances = load_instances(options)


	default_instance = { :gucid => 'default', :instance_type => 'SSH',
	                     :status => '0', :ban_duration => 6000,
	                     # change pcap & log to some other shit like nil
	                     :pcap_location => 'pcap.log',
	                     :log_location => 'log.log',
	                     :strace_location => 'strace.log' }

#man.instance_manager(default_instance,options)


	return default_instance, instances, root, options
end

def first_run(options)
	options[:cid] = Digest::SHA1.hexdigest(($$ ^ Time.now.to_i).to_s)
end

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
			 "ERROR: loaded_i.nil?"
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
