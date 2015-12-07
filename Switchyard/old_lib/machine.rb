class Machine <  ActiveRecord::Base
	belongs_to :user
	has_many :instances
	#attr_accessible :name, :hostname, :ip, :cid
	validate :cid, :length => {:is => 44}, :uniqueness => true

	def just_seen(ip=none)
		self.alive = Time.now.utc
		self.ip = ip
		if self.installed != true
			self.installed = true
		end
		self.save!
	end	

	def sub_instance_avail?
		instance = self.instances.find(:first, :conditions =>
			["subscribed = ? and installed = ?", true, false])
		if instance
			return instance
		else
			return false
		end		
	end


end
