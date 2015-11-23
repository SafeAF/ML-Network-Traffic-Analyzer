require 'daemons'

p "Usage: ruby messageserv.rb start|restart|stop (optional args)" if ARGV[0] == 'help'
Daemons.run('messagehub.rb')