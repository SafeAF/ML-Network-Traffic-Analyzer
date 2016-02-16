#!/bin/bash
# Emergence init.d script
dir="/etc/emergence"
cd $dir
running="$(ps aux | grep 'ruby /etc/emergence/main.rb' | grep -v 'grep' | wc -l)"
pid="$(ps aux | grep 'ruby /etc/emergence/main.rb' | grep -v 'su' | grep -v 'grep' | awk '{print $2}')"
sniffer_pid="$(ps aux | grep 'ruby /etc/emergence/sniffer.rb' | grep -v 'grep' | awk '{print $2}')"

function start_emergence {
	ruby /etc/emergence/sniffer.rb &
	su emergence -c "ruby /etc/emergence/main.rb" &
	}
function stop_emergence {
	kill -INT $sniffer_pid $pid
	}

case "$1" in
	start)
		if [ $running -ge 1 ]
		then
			echo "Emergence is already running."
			exit 1
		else
			start_emergence
		fi;;
	restart)
		if [ $running -ge 1 ]
		then
			stop_emergence
			start_emergence
		else
			echo "Emergence is not running. Using 'start' instead..."
			start_emergence
		fi;;
	stop)
		if [ $running -ge 1 ]
		then
			stop_emergence
		else
			echo "Emergence is not running."
		fi;;
	*)
		echo "Usage: /etc/init.d/emergence [start | restart | stop]"
		exit 1;;
esac
