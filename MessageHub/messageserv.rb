#!/usr/bin/env ruby
require 'daemons'

p "Usage: ruby messageserv.rb start|restart|stop (optional args)" if ARGV[0] == 'help'
p "[#{Time.now}]: Firing messageServ prepare to be fuckin informed bitch! Let me speak the truth again"
Daemons.run('messagehub.rb')