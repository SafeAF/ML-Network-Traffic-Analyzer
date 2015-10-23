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
