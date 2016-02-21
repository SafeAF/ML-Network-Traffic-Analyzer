
class Instance < ActiveRecord::Base
	belongs_to :machine
	has_one :conf
	has_many :messages
	#attr_protected :gucid
	validate :gucid, :length => {:is => 44}, :uniqueness => true

# validate that gucid is unique

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


	def self.generate_gucid(type, obj)
		n = obj.object_id ^ Time.now.to_i
		hash = Digest::SHA1.hexdigest(n.to_s)
		hash = type.upcase + "_" + hash
	end  

	def return_conf_json
		[self.conf, self.instance_type].to_json
	end

	def serialize_conf
		return no_subs_found_err unless self.subscribed == true
		config = serialize(hashify(self.conf))
		config += '::GUCID==' + self.gucid + '::INSTANCE_TYPE==' +
			self.instance_type
	end

	def just_seen(ip=none)
		self.alive = Time.now.utc
		if self.installed != true
			self.installed = true
		end
		self.save!
	end	



end



class Message < ActiveRecord::Base
	belongs_to :instance

end

class Conf < ActiveRecord::Base
	belongs_to :instance
#	attr_accessible :log_location, :error_log, :denyfile_location, 
#		:ban_duration, :pcap_filter, :pcap_location, :pcap_interface,
#		:retry
end






