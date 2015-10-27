
module Server
class Server <  ActiveRecord::Base
	include Redis::Objects

	hash_key :logged_in_users
	hash_key :last_logged

	belongs_to :user
	has_many :services  #, :autosave => true
	has_many :applications
	has_many :processes
	belongs_to :cluster
	has_many :statistics
	belongs_to :network
	has_many :configurations

	has_many :statistics
	belongs_to :machine
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
end

end
