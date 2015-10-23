#!/usr/bin/ruby -w
$:.unshift File.join(File.dirname(__FILE__))

require 'digest/sha1'
require 'uri'
require 'socket'
require 'net/https'
require 'logger'
require 'yaml'
require 'inline'
require 'json'
#require 'pcaplet'

### Run bundle install --path vendor --binstubs to carry cems around in vendor/
### use rvm no apt-get ruby/ ruby gems
## apt-get install libpcap0.8 and -dev
## Gem install RubyInline


#FATAL:	an unhandleable error that results in a program crash
#ERROR:	a handleable error condition
#WARN:	a warning
#INFO:	generic (useful) information about system operation
#DEBUG:	low-level information for developers


### TODO list ###
# api key and api password not user password
# unique install script w/ username and apikeyhash on install
# encrypt config file
# iptables support via riptables
# implement Class: Tempfile secure temporary files, 'ensure close'
# and make threadsafe  or use jruby
# find where "nil" instance is added

# add dummy stats features

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

#########libsniffer########
class Libsniffer
	#inline :C do |builder|
	inline(:C) do |builder|
		# prefix required for structs, #defines and #includes
		builder.prefix %q{
		#include <stdio.h>
		#include <pcap.h>
		#include <string.h>
		#include <stdlib.h>
		#include <ctype.h>
		#include <errno.h>
		#include <sys/types.h>
		#include <sys/socket.h>
		#include <netinet/in.h>
		#include <arpa/inet.h>
		#define SNAP_LEN 1518
		#define SIZE_ETHERNET 14
		#define ETHER_ADDR_LEN	6
		struct sniff_ethernet {
        	u_char  ether_dhost[ETHER_ADDR_LEN];
        	u_char  ether_shost[ETHER_ADDR_LEN];
        	u_short ether_type;
			};
		struct sniff_ip {
        	u_char  ip_vhl;
        	u_char  ip_tos;
        	u_short ip_len;
        	u_short ip_id;
        	u_short ip_off;
        	#define IP_RF 0x8000
        	#define IP_DF 0x4000
        	#define IP_MF 0x2000
        	#define IP_OFFMASK 0x1fff
        	u_char  ip_ttl;
        	u_char  ip_p;
        	u_short ip_sum;
        	struct  in_addr ip_src, ip_dst;
			};
		#define IP_HL(ip)               (((ip)->ip_vhl) & 0x0f)
		#define IP_V(ip)                (((ip)->ip_vhl) >> 4)
		typedef u_int tcp_seq;
		struct sniff_tcp {
        	u_short th_sport;
        	u_short th_dport;
        	tcp_seq th_seq;
        	tcp_seq th_ack;
        	u_char  th_offx2;
			#define TH_OFF(th)      (((th)->th_offx2 & 0xf0) >> 4)
        	u_char  th_flags;
        	#define TH_FIN  0x01
       		#define TH_SYN  0x02
        	#define TH_RST  0x04
        	#define TH_PUSH 0x08
        	#define TH_ACK  0x10
        	#define TH_URG  0x20
        	#define TH_ECE  0x40
        	#define TH_CWR  0x80
        	#define TH_FLAGS        (TH_FIN|TH_SYN|TH_RST|TH_ACK|TH_URG|TH_ECE|TH_CWR)
        	u_short th_win;
        	u_short th_sum;
        	u_short th_urp;
			};
		FILE *logfile;
		}

		builder.c %q{
	void got_packet(u_char *args, const struct pcap_pkthdr *header, const 	u_char *packet) {
	static int count = 1;                   /* packet counter */

	/* declare pointers to packet headers */
	const struct sniff_ethernet *ethernet;  /* The ethernet header [1] */
	const struct sniff_ip *ip;              /* The IP header */
	const struct sniff_tcp *tcp;            /* The TCP header */
	const char *payload;                    /* Packet payload */

	int size_ip;
	int size_tcp;
	int size_payload;

	printf("\nPacket number %d:\n", count);
	count++;

	/* define ethernet header */
	ethernet = (struct sniff_ethernet*)(packet);

	/* define/compute ip header offset */
	ip = (struct sniff_ip*)(packet + SIZE_ETHERNET);
	size_ip = IP_HL(ip)*4;
	if (size_ip < 20) {
		printf("   * Invalid IP header length: %u bytes\n", size_ip);
		return;
	}

	/* print source and destination IP addresses */
	printf("       From: %s\n", inet_ntoa(ip->ip_src));
	printf("         To: %s\n", inet_ntoa(ip->ip_dst));

	/* determine protocol */
	switch(ip->ip_p) {
		case IPPROTO_TCP:
			printf("   Protocol: TCP\n");
			break;
		case IPPROTO_UDP:
			printf("   Protocol: UDP\n");
			return;
		case IPPROTO_ICMP:
			printf("   Protocol: ICMP\n");
			return;
		case IPPROTO_IP:
			printf("   Protocol: IP\n");
			return;
		default:
			printf("   Protocol: unknown\n");
			return;
	}

	/*
	 *  OK, this packet is TCP.
	 */

	/* define/compute tcp header offset */
	tcp = (struct sniff_tcp*)(packet + SIZE_ETHERNET + size_ip);
	size_tcp = TH_OFF(tcp)*4;
	if (size_tcp < 20) {
		printf("   * Invalid TCP header length: %u bytes\n", size_tcp);
		return;
		}

	printf("   Src port: %d\n", ntohs(tcp->th_sport));
	printf("   Dst port: %d\n", ntohs(tcp->th_dport));

	/* define/compute tcp payload (segment) offset */
	payload = (u_char *)(packet + SIZE_ETHERNET + size_ip + size_tcp);

	/* compute tcp payload (segment) size */
	size_payload = ntohs(ip->ip_len) - (size_ip + size_tcp);

	if (size_payload > 0) {
		printf("   Payload (%d bytes):\n", size_payload);
		// write capture to log file
		fprintf(logfile, "%s::%s::%d::%d~~~", inet_ntoa(ip->ip_src), inet_ntoa(ip->ip_dst), ntohs(tcp->th_sport), ntohs(tcp->th_dport) );
		const u_char *ch = payload;
		int i;
		for (i = 0; i < size_payload; i++) {
			fprintf(logfile, "%02x", *ch);
			ch++;
			}
		fprintf(logfile, "\n");
		}
	return;
	}
	}
		builder.c %q{
	void sniff(char *interface, char *filter, char *log_location) {
		char errbuf[PCAP_ERRBUF_SIZE];
		pcap_t *handle;
		struct bpf_program fp;
		bpf_u_int32 net_mask;
		bpf_u_int32 net_ip;
		struct pcap_pkthdr header;
		logfile = fopen(log_location, "w");

	handle = pcap_open_live(interface, BUFSIZ, 0, 1000, errbuf);
	if (handle == NULL) {
		fprintf(stderr, "Couldn't open interface %s: %s\n", interface, errbuf);
		return(2);
		}
	// get device details
	if (pcap_lookupnet(interface, &net_ip, &net_mask, errbuf) == -1) {
		fprintf(stderr, "Couldn't get netmask for device %s: %s\n", interface, errbuf);
		net_ip = 0;
		net_mask = 0;
		}
	// compile filter
	if (pcap_compile(handle, &fp, filter, 0, net_ip) == -1) {
		fprintf(stderr, "Couldn't parse filter %s: %s\n", filter, 				pcap_geterr(handle));
		return(2);
		}
	// set filter
	if (pcap_setfilter(handle, &fp) == -1) {
		fprintf(stderr, "Couldn't install filter %s: %s\n", 		 				filter, pcap_geterr(handle));
		return(2);
		}
	printf("Interface: %s\n", interface);
	printf("Filter: %s\n", filter);
	printf("Log Location: %s\n", log_location);
	printf("got_packet address: %x\n", got_packet);
	pcap_loop(handle, -1, *got_packet, NULL);
	pcap_freecode(&fp);
	pcap_close(handle);
	return;
	}

	}
	end
end

######### libcore#############

class Core
	attr_writer :elogger, :logger

	def initialize
		@elogger = Logger.new($OPT[:error_log], 'weekly')
		@elogger.level = Logger::WARN

		@logger = Logger.new($OPT[:log_file], 'weekly')
		@logger.level = Logger::WARN
	end
end

class Instance < Core
	attr_accessor :log_location, :pcap_location, :strace_location,
	              :instance_type, :status, :gucid, :ban_duration,
	              :hostname, :pcap_port, :pcap_filter, :pcap_interface,
	              :pcap_thread_flag, :message, :stats_log, :stats_pcap,
	              :monitor_log, :monitor_pcap, :sniffer_thread

	def initialize(ins_conf)
		@gucid = ins_conf[:gucid]
		@pcap_thread_flag = 0
#		@hostname = Socket.gethostname
		@message = ""
	end

	def set_conf(ins_conf)
		return if gucid.nil?
		# FUTURE: we want instance.conf = ins_conf
		@gucid = ins_conf[:gucid]
		@log_location = ins_conf[:log_location]
		@instance_type = ins_conf[:instance_type]
		@status = ins_conf[:status]
		@ban_duration = ins_conf[:ban_duration]
		@pcap_location = ins_conf[:pcap_location]
		@strace_location = ins_conf[:strace_location]
		@pcap_port = ins_conf[:pcap_port]
		@pcap_filter = ins_conf[:pcap_filter]
		@pcap_interface = ins_conf[:pcap_interface]
		@message = ins_conf[:message]
		#		@pcap_thread_flag = ins_conf[:pcap_thread_flag]
		@stats_log = ins_conf[:stats_log]
		@stats_pcap = ins_conf[:stats_pcap]
		@monitor_log = ins_conf[:monitor_log]
		@monitor_pcap = ins_conf[:monitor_pcap]
	end

	# add support for binary files, as a param to get_log
	def get_pcap_log(location)
		return if location.nil?
		#	original getlog
		log = []
		log0 = []
		unless File.exists? location
			File.open($ROOT + "/" + "#{location}", 'w').close
		end
		if File.size(location) > 0
			log0 = array_a_file($ROOT + "/" + "#{location}" + "0")
		end
		log = array_a_file(location)
		if log.nil?
			return nil
		end
		if log0.nil?
			return log
		end
		dupelesslogs = (log | log0) - (log & log0)
		# write log to log0 for later diffing
		log0 = File.open($ROOT + "/" + "#{location}" + "0", 'w') # was w+
		log.each {|entry|
			log0.puts(entry)
			log0.flush
		}
		log0.close
		return dupelesslogs
	end

	def clean_log(location)
		return if location.nil?
		return if not File.exists? location
		if File.size(location) > 0
			log = File.open(location, 'w')
			log.truncate(0)
			log.close
		end
	end

end

class InstanceManager
	attr_accessor :instances
	def initialize
		@instances = Hash.new
	end

	def find_by_gucid(gucid)
		if @instances.include? gucid
			return @instances[gucid]
		end
	end

	def instance_manager(ins_conf, options)
		instance = find_by_gucid(ins_conf[:gucid])
		if instance.is_a?(Instance) # found instance with that gucid
			# delete instance if ::delete
			#			instance.key = ins_conf[key]
			unless ins_conf[:delete].nil?
				instance.destroy
			end
			# FUTURE: we want instance.config = ins_conf
			instance.set_conf(ins_conf)
			# BUG: make sure to add deny file support

			if not ins_conf[:denyfile_location].nil?
				options[:deny_file] = ins_conf[:denyfile_location]
			end

		elsif instance.nil? # cant find instance with that gucid
			@instances[ins_conf[:gucid]] = Instance.new(ins_conf)

		else
			# do nothing
		end
	end
end

#################LIB REDOX ############

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
	# FIXME I have swapped this  out for JSON.parse, should be drop-in
	c = JSON.parse(parcel)
	# parcel.split(/::/).each do |item|
	# 	item.gsub!(/[\\\"]*/, '')
	# 	key, value = item.split(/==/)
	# 	next if key.nil?
	# 	next if value.nil?
	# 	key.downcase!
	# 	symbol = :"#{key}"
	# 	c[symbol] = value
	# end
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
			# FIXME replace crappy serialization technique with json
			# FIXME look into using messagepack
			pcap_logfile.push headers + "~~" + features + "\n"
		}
	}
	return if pcap_logfile == []
	jlog_pcap = JSON.generate(pcap_logfile)
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
				                  'pcap_log' => jlog_pcap,
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

#
		options = YAML::load(config)
		config.close
		if options.is_a? Hash
			options
		else
			options = {
					:config_file => 'config.em',
					:instances_file => 'instances.em',
					:port => "7000",
					:host => 'sw1.baremetalnetworks.com',
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

############ LIBEM ########################

class Libem
	inline :C do |builder|
		builder.c %q{
			static VALUE calc_unigrams(VALUE payload) {
				VALUE unigram_hash = rb_hash_new();
				char *data = STR2CSTR(payload);
				int i;
				char unigram[2];
				VALUE count;
				for (i = 0; i <= strlen(data) - 1; i++) {
					snprintf(unigram, sizeof(unigram), "%1c", data[i]);
					if (NIL_P(rb_hash_aref(unigram_hash,
							rb_str_new2(unigram))))
						count = INT2NUM(1);
					else {
						count = rb_hash_aref(unigram_hash,
							rb_str_new2(unigram));
						count = INT2NUM(NUM2INT(count) + 1);
						}
					rb_hash_aset(unigram_hash,
						rb_str_new2(unigram), count);
					}
				return unigram_hash;
				}
			}
	end
	inline :C do |builder|
		builder.c %q{
			static VALUE calc_bigrams(VALUE payload) {
				VALUE bigram_hash = rb_hash_new();
				char bigram[3];
				char *data = STR2CSTR(payload);
				int i, count;
				for (i = 0; i <= strlen(data) - 1; i++) {
					if (i <= (strlen(data) - 2)) {
						snprintf(bigram, sizeof(bigram), "%1c%1c",
								data[i], data[i+1]);
						if (NIL_P(rb_hash_aref(bigram_hash,
								rb_str_new2(bigram))))
							count = INT2NUM(1);
						else {
							count = rb_hash_aref(bigram_hash,
								rb_str_new2(bigram));
							count = INT2NUM(NUM2INT(count) + 1);
							}
						rb_hash_aset(bigram_hash,
							rb_str_new2(bigram), count);
						}
					}
				return bigram_hash;
				}
			}
	end
	inline :C do |builder|
		builder.c %q{
			static VALUE calc_stats(VALUE payload) {
				char *data  = STR2CSTR(payload);
				VALUE stats_hash = rb_hash_new();
				int i, total_chars = 0, count_zero = 0;
				int count_visible = 0;
				int count_nonvisible = 0;
				int count_bigrams = 0;
				double prop_visible = 0;
				double prop_nonvisible = 0;
				double prop_zero = 0;
				for (i = 0; i <= strlen(data) - 1; i++) {

					total_chars++;
					if (data[i] >=32 && data[i] <= 128)
						count_visible++;
					else if (data[i] < 32 || data[i] > 128)
						count_nonvisible++;
					if (data[i] == 48) count_zero++;
					}
				prop_visible = (double) count_visible / total_chars;
				prop_nonvisible = (double) count_nonvisible /
					total_chars;
				prop_zero = (double) count_zero / total_chars;
				rb_hash_aset(stats_hash, rb_str_new2("total_chars"),
					INT2NUM(total_chars));
				rb_hash_aset(stats_hash, rb_str_new2("count_visible"),
					INT2NUM(count_visible));
				rb_hash_aset(stats_hash, rb_str_new2("count_nonvisible"),
					INT2NUM(count_nonvisible));
				rb_hash_aset(stats_hash, rb_str_new2("count_zero"),
					INT2NUM(count_zero));
				rb_hash_aset(stats_hash, rb_str_new2("prop_visible"),
					rb_float_new(prop_visible));
				rb_hash_aset(stats_hash, rb_str_new2("prop_nonvisible"),
					rb_float_new(prop_nonvisible));
				rb_hash_aset(stats_hash, rb_str_new2("prop_zero"),
					rb_float_new(prop_zero));
				return stats_hash;
				}
			}
	end

	def prepare_features(payload)
		features = ""
		ug = []
		bg = []
		stat = []
		ugs = self.calc_unigrams(payload)
		bgs = self.calc_bigrams(payload)
		stats = self.calc_stats(payload)
		stats["count_unigrams"] = ugs.keys.count
		stats["count_bigrams"] = bgs.keys.count
		stats["mf_unigram"] = ugs.max_by {|key, value| value}
		stats["prop_mf_unigram"] = ugs.values.max.quo(stats["count_unigrams"]).to_f
		stats["mf_bigram"] = bgs.max_by {|key, value| value}
		stats["prop_mf_bigram"] = bgs.values.max.quo(stats["count_bigrams"]).to_f

		stats.sort.each {|key,value|
			features += value.to_s + ','
		}
		features.chomp! ","
		features
	end
end




###########################################


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

loop do
	begin
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
	rescue => err
		puts "[#{Time.now}] Error: #{err.pretty_print_inspect} @line: #{__LINE__}
 @file: #{__FILE__} "
		sleep 10
		retry
	end

 end ## END LOOP


ensure
	save_config $OPT
	save_instances man.instances, $OPT
	exit
end


trap("INT") do finish(man) end
def finish(man)
	p "Cleaning up..."
	save_config $OPT
	save_instances man.instances, $OPT
	exit!
end


