
options = Hash.new
options[:host] = 'clusterforge.us'
options[:port] = '7000'
options[:user] = 'foo'
options[:pass] = 'bar'
options[:version] = 'submit-harness-pre-0.2.0'
options[:cid] = 'cid400f0sfs053353325235325235'


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

def submit_to_switchyard(logfile, pcapfile, options)

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
