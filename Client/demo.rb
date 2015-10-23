


class String
	def self.to_hex
		return if self.nil?
		ret = ""
		for i in (0..self.length)
			unless self[i].nil?
				ret += self[i].to_s(16)
			end
		end
		ret
	end

	def self.splitify( pat)
		self.split(/#{pat}/)
	end
end



def timebox
	a = Time.now.to_s.split(/ /)
	a[3]
end

def array_a_file(location)
	if FileTest.exists? location
		log = File.open(location, 'r')
		if log.nil?
			log.close
			return nil
		elsif log.respond_to?("each")
			logs = []
			log.each {|entry| logs.push(entry)}
			log.close
			return logs
		else
			log.close
			@elogger.warn(get_time + '(WARNING) ' +
					              'Error with logfile at #{location}')
			return nil
		end
	else
#			@elogger.warn(get_time + '(WARNING) ' +
#				'Error file #{location} does not exist.')
		return nil
	end
end