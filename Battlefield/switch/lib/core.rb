private



#### LIBRARY FUNCTIONS ####	
	# come up with a cleaner algo for sending and receiving data
	# not just plain text ::foo==bar::dog==cat etc, uses too many bytes
	
	def serialize(kit)
		return if kit.nil?

		if kit.respond_to? :array
			kit.each do |key|
				next if key.nil?
				next if kit[key].nil?
				snippet = '::' + key.upcase + '==' + kit[key].chomp.chomp
				message += snippet
			end
			return message

		elsif kit.respond_to? :hash
			message = ''
			kit.each_key do |key|
				next if key.nil?
				next if kit[key].nil?
				snippet = '::' + key.upcase + '==' + kit[key].chomp.chomp
				message += snippet
			end
			return message
		end
	end

	def hashify(thing)
		hashy = Hash.new
		unless thing.nil? 
		# comma is a bad thing to split on
		# fix this implementation
		 thing.inspect.split(',').each { |opt| 
			next if opt.nil?
			opt.strip!
			# FIXME: shitty hack 
			opt.gsub!(/"/, "")
			opt.gsub!(/\\/, "")
			opt.gsub!(/\>/, "")

			key, value = opt.split(':')
			key.strip!
			value.strip!

			hashy[key] = value
		 }
		end
		return hashy
	end


