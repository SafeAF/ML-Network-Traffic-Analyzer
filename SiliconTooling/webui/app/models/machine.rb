class Machine <  ActiveRecord::Base
	belongs_to :user
	has_many :instances
	belongs_to :cluster
	has_many :statistics
	has_many :servers
	has_many :nodes
	has_many :applications
	has_many :processes
	has_many :connections
	has_many :harddisks
	has_many :logfiles
	belongs_to  :manager
	belongs_to :network
	belongs_to :infrastructure
	has_many :messages
	has_many :notifications

	#attr_accessible :name, :hostname, :ip, :cid
	#validate :cid, :length => {:is => 44}, :uniqueness => true

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
