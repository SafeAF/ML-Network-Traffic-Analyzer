

dispatch {
	'bar' => lambda {|x| p x},
			:sudo => lambda {|x| channel.exec "sudo -p 'sudo password: ' #{command}" do |channel, success|
		abort "Could not execute sudo #{command} unless success"
		channel.on_data do |channel, data|
			retstr += "Connection: #{data}"
			if data =~ /sudo password: /
				ch.send_data("password\n")
			end ; return retstr ; end ; end },
			:foo => lambda {|x| }
}
