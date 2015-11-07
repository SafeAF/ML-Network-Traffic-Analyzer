class Message  < ActiveRecord::Base
	belongs_to :user
	belongs_to :machines
	belongs_to :cluster
	belongs_to :server
	belongs_to :application
	belongs_to :service
	belongs_to :process


end