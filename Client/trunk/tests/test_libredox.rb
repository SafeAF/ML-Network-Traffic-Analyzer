require 'test/unit'
require 'yaml'
require 'libredox'

class TestLibredox < Test::Unit::TestCase
	def test_array_a_file
		test_file = File.open('test_data.txt', 'w')
		1.upto(5) {|x| test_file.puts "Test String Line " + x.to_s}
		test_file.close
		test_array = array_a_file('test_data.txt')
		1.upto(5) {|x| assert_equal test_array[x - 1], 
						"Test String Line " + x.to_s + "\n"}
		File.delete('test_data.txt')
	end

	def test_parse_deny_file
		options = {:deny_file => 'deny.txt'}
		deny_hosts = File.open options[:deny_file], 'w'
		
		deny_hosts.puts "SSH: 10.0.0.254"
		deny_hosts.puts "FTP: 172.16.2.128"
		deny_hosts.puts "SSH: 192.168.1.192"
		deny_hosts.close
		denied_hosts = []
		denied_hosts = parse_deny_file(options)
		assert_equal denied_hosts[0], "10.0.0.254"
		assert_equal denied_hosts[1], "172.16.2.128"
		assert_equal denied_hosts[2], "192.168.1.192"
		File.delete options[:deny_file]
	end

	def test_add_to_deny_file
		deny_file = File.open("deny.txt", 'w+')
		existing_deny = ["ALL: 10.0.0.254", "ALL: 172.16.2.128", 
				"ALL: 192.168.1.192"]
		existing_deny.each {|ip|
			deny_file.puts ip
			}
		deny_file.close
		new_deny = ["10.1.1.10", "192.168.23.224", "172.16.128.12"]
		add_to_deny_file(new_deny, 'deny.txt')
		formatted_deny = []
		new_deny.each {|x|
			formatted_deny.push "ALL: " + x
			}
		verify_deny_set = existing_deny + formatted_deny
		written_deny_set = array_a_file("deny.txt")
		written_deny_set.map {|x|
			x.chomp!
			}
		assert_equal verify_deny_set, written_deny_set
	end

	def test_ban
		options = {:deny_file => 'deny.txt'}
		to_ban = ['10.0.0.1', '10.0.0.2', '10.0.0.3']
		deny_file = File.open options[:deny_file], 'w'
		to_ban.each {|ip|
			deny_file.puts "ALL: " + ip
			}
		deny_file.close
		to_ban.push "10.0.0.4"
		ban(to_ban, options)
		verify_deny_set = []
		to_ban.each {|ip|
			verify_deny_set.push "ALL: " + ip
			}
		written_deny_set = []
		written_deny_set = array_a_file options[:deny_file]
		written_deny_set.map {|x|
			x.chomp!
			}
		assert_equal verify_deny_set, written_deny_set
	end

	def test_remove_from_deny_file
		options = {:deny_file => 'deny.txt'}
		deny_file = File.open 'deny.txt', 'w'
		1.upto(5) {|x|
			deny_file.puts "ALL: 10.0.0." + x.to_s
			}
		deny_file.close
		deny_list = ['10.0.0.5', '10.0.0.4']
		unban deny_list, options
		expected_deny_list = ['ALL: 10.0.0.1', 'ALL: 10.0.0.2', 
							'ALL: 10.0.0.3']
		written_deny_list = array_a_file options[:deny_file]
		written_deny_list.map {|x|
			x.chomp!
			}
		File.delete 'deny.txt'
		assert_equal expected_deny_list, written_deny_list
	end

	def test_save_config
		options = {
			:config_file => 'test_config.em',
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
			:serv_rotate_max => 5,
			}
		save_config(options)
		written_config = []
		written_config = array_a_file(options[:config_file]).join
		assert_equal YAML.dump(options), written_config
		File.delete options[:config_file]
	end

	def test_load_config
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
			:serv_rotate_max => 5,
			}
		conf_file = File.open options[:config_file], 'w'
		YAML.dump(options, conf_file)
		conf_file.close
		written_config = load_config
#		File.delete options[:config_file]
		assert_equal options, written_config
	end

	def test_rotate_hosts
		
		prefix = 'sw'
		host = 'sw1.bmnlabs.com'
		min = 2
		max = 2
		result = rotate_hosts(prefix, host, min, max)
		assert_equal 'sw2.bmnlabs.com', result
	end
end
