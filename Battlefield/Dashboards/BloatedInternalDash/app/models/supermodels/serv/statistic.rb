class Statistic < ActiveRecord::Base
	belongs_to :machine
belongs_to :service
belongs_to :user
belongs_to :server
belongs_to :application
	belongs_to :network
	belongs_to :process
end
