class Configuration < ActiveRecord::Base
	belongs_to :machine
	belongs_to :server
	belongs_to :service
	belongs_to :application

end