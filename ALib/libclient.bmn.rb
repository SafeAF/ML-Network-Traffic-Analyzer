#### Libclient.bmn.rb

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