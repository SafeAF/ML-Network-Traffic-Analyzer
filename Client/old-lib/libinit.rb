#require 'crypt/blowfish'

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
