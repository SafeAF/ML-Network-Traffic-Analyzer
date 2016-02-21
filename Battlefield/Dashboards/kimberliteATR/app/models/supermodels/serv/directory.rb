class Directory  < ActiveRecord::Base
	belongs_to :machine
	belongs_to :server
	belongs_to :application
	belongs_to :service
	belongs_to :process
	belongs_to :harddrive

	has_many :files
end