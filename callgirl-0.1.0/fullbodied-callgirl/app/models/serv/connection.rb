class Connection  < ActiveRecord::Base
	include Redis::Objects
	list :established
	list :listeners
	list :close_wait
	belongs_to :machine
	belongs_to :server
	belongs_to :application
	belongs_to :service
	belongs_to :process
	belongs_to :network
end