require 'test/unit'
require 'libinstance'
require 'libredox'

class TestLibinstance < Test::Unit::TestCase

	@example_options = {
							:config_file => 'config.em',
							:instances_file => 'instances.em',
							:port => "7000",
							:host => 'sw1.bmnlabs.com',
							:user => 'foo',
							:pass => 'bar',
							:deny_file => "hosts.small",
							:error_log => 'error.log',
							:delay => 10,
							:retry => 10,
							:message => "",
							:cid => nil,
							:version => nil,
							}
	@example_instance_config = {
							:gucid => 'default', 
							:log_location => 'foo.bar',
							:instance_type => 'default_instance',
							:status => 'default_status',
							:pcap_location => 'log.txt',
							:strace_location => 'strace.txt',
							:pcap_port => 80,
							:pcap_filter => 'tcp and dst',
							:pcap_interface => 'eth0',
							:message => 'default message'}



	def test_initialize
		example_ins_conf = {:gucid => 'bar'}
		default = Instance.new(example_ins_conf)
		assert_equal default.gucid, 'bar'
	end

	def test_set_conf
		default = Instance.new({:gucid => 'bar', :pcap_thread_flag => 0,
				:hostname => 'host', :message => ''})
		example_ins_conf = {:gucid => 'default', 
							:log_location => 'foo.bar',
							:instance_type => 'default_instance',
							:status => 'default_status',
							:pcap_location => 'log.txt',
							:strace_location => 'strace.txt',
							:pcap_port => 80,
							:pcap_filter => 'tcp and dst',
							:pcap_interface => 'eth0',
							:message => 'default message'}
		default.set_conf example_ins_conf

		#the following assertion chokes on nil? need exception handling
		assert_equal default.gucid, 'default'
		assert_equal default.log_location, 'foo.bar'
		assert_equal default.instance_type, 'default_instance'
		assert_equal default.status, 'default_status'
		assert_equal default.pcap_location, 'log.txt'
		assert_equal default.strace_location, 'strace.txt'
		assert_equal default.pcap_port, 80
		assert_equal default.pcap_filter, 'tcp and dst'
		assert_equal default.pcap_interface, 'eth0'
		assert_equal default.message, 'default message'
	end

	def test_get_pcap_log
		$ROOT = "."
		test_file = File.open 'test_file.txt', 'w'
		test_file0 = File.open 'test_file.txt0', 'w'
		1.upto(5) {|x| test_file.puts "Test String Line " + x.to_s}
		1.upto(4) {|x| test_file0.puts "Test String Line " + x.to_s}
		test_file.close
		test_file0.close
		assert_not_equal File.size('test_file.txt'), 0
		default = Instance.new({:gucid => 'test'})
		dupeless = default.get_pcap_log('test_file.txt')
		assert_equal dupeless[0], "Test String Line 5\n"
		File.delete('test_file.txt')
		File.delete('test_file.txt0')
	end

	def test_clean_log
		default = Instance.new({:gucid => 'test'})
		test_file = File.open 'test_file.txt', 'w'
		1.upto(5) {|x| test_file.puts "Test String Line " + x.to_s}
		test_file.close
		default.clean_log('test_file.txt')
		assert_equal File.size('test_file.txt'), 0
		File.delete('test_file.txt')
	end

	def test_find_by_gucid
		default = Instance.new({:gucid => 'test'})
		man = InstanceManager.new 
		man.instances['default'] = default
		man.instance_manager({:gucid => 'test'}, @example_options)
		instance = man.find_by_gucid('test')
		assert_equal instance.gucid, 'test'
	end

	def test_instance_manager
		example_instance_config = {
							:gucid => 'default', 
							:log_location => 'foo.bar',
							:instance_type => 'default_instance',
							:status => 'default_status',
							:pcap_location => 'log.txt',
							:strace_location => 'strace.txt',
							:pcap_port => 80,
							:pcap_filter => 'tcp and dst',
							:pcap_interface => 'eth0',
							:message => 'default message'}
		test_instance = Instance.new({:gucid => 'test'})
		man = InstanceManager.new
		man.instances['test'] = test_instance
		man.instance_manager({:gucid => 'default'}, @example_options)
		assert_equal man.instances['default'].gucid,
			example_instance_config[:gucid]
	end
end
