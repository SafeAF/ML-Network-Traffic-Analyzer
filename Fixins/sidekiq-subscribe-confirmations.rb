def confirmations_thread(messages_limit, *channels)
	parent = Thread.current
	thread = Thread.new {
		confirmations = []
		Sidekiq.redis do |conn|
			conn.subscribe *channels do |on|
				on.subscribe do |ch, subscriptions|
					if subscriptions == channels.size
						sleep 0.1 while parent.status != "sleep"
						parent.run
					end
				end
				on.message do |ch, msg|
					confirmations << msg
					conn.unsubscribe if confirmations.length >= messages_limit
				end
			end
		end
		confirmations
	}
	Thread.stop
	yield if block_given?
	thread
end