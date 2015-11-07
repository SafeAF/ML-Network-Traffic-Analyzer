class Application  < ActiveRecord::Base
	include Redis::Objects
	value :state
	value :pid
	list :file_descriptors
	list :log_file
	list :error_log
	list :rconnections

	has_many :connections
	has_many :processes
	has_many :configurations
 def id
		@uid =  Digest::SHA1.hexdigest(Object.object_id ^ Time.now.to_i)
	 end


 end

