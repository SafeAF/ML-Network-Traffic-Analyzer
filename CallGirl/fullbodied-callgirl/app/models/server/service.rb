class Service <  ActiveRecord::Base

	belongs_to :machine
	belongs_to :server
	belongs_to :node
belongs_to :user
belongs_to :cluster
has_many :statistics
	has_many :configurations
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