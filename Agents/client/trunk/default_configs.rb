#!/usr/bin/ruby -w
# Encrypt plaintext config files

require 'rubygems'
require 'crypt/blowfish'
require 'yaml'

keyfile = ARGV[1] || "/etc/emergence/key"

unless File.exists? keyfile
	file = File.open(keyfile, "w+")
	key = Digest::SHA1.hexdigest(($$ ^ Time.now.to_i).to_s)
	file.puts key
	file.close
	File.chmod(0400, keyfile)
end

key = File.read(keyfile)

default_instance = { :gucid => 'default', :instance_type => 'SSH', 
			:status => '0', :ban_duration => 6000,
			:pcap_location => 'pcap.log', 
			:log_location => 'log.log',
			:strace_location => 'strace.log' }

options = {:config_file => 'config.em', :instances_file => 'instances.em',
			:port => "7000", :host => 'sw1.bmnlabs.com',
			:user => 'foo', :pass => 'bar',
			:deny_file => "hosts.small",
			:error_log => 'error.log', :delay => 10,
			:retry => 10, :message => "", :cid => nil,
			:version => nil, :serv_rotate_min => 1,
			:serv_rotate_max => 1,
			}

file = File.open(keyfile, 'r')
key = file.gets
file.close

blowfish = Crypt::Blowfish.new(key)

#write config.em
file = File.open("/etc/emergence/config.em", 'wb+')
yaml_dump = YAML.dump(options)
ciphered = blowfish.encrypt_string yaml_dump
file.write(ciphered)
file.close

#write instances.em
file = File.open("/etc/emergence/instances.em", 'wb+')
#yaml_dump = YAML.dump(default_instance)
#p yaml_dump
ciphered = blowfish.encrypt_string "--- 
default: !ruby/object:Instance 
  ban_duration: 
  gucid: default
  instance_type: 
  log_location: 
  message: 
  pcap_filter: 
  pcap_interface: 
  pcap_location: 
  pcap_port: 
  pcap_thread_flag: 0
  status: 
  strace_location: 
"
file.write(ciphered)
file.close
