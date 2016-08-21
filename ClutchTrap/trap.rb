
def constructor(verb, event)
  "#{Time.now}-#{$hostname}-> #{$DIR}/#{event.name} was #{verb}"
end


begin
	$DIR =  '/etc'
	start_time = Time.now
	events = 0
  DRb.start_service
  screen = DRbObject.new_with_uri(nil, 'druby://localhost:1900')

	hook = INotify::Notifier.new
	hook.watch($DIR, :create, :delete, :modify, :moved_from) do |event|
		next if event.nil?
	  Thread.new { screen.push_notify(event) }
    Thread.join
			p "Event name: #{event.name} \n"
		parser(event)
		events += 1
		if events > $options[:eventsPerMail] && $MAILER
			events_threshold =  Time.now
			seconds_to_event_threshold = events_threshold - start_time
			start_time = Time.now
			events_threshold = ''
			mailer(events, ARGV[1], seconds_to_event_threshold)

		end
	#	sleep 5
	end

	hook.run ### see #A1


rescue => err
	#$logger.info "#{Time.now}: Error: #{err.inspect}"

end

#############

#A1
 # Wait 10 seconds for an event then give up
#  if IO.select([notifier.to_io], [], [], 10)
#    notifier.process
#  end
######################
## It can even be used with EventMachine:
#
#  require 'eventmachine'
#
#  EM.run do
#    EM.watch notifier.to_io do
#      notifier.process
#    end
#  end