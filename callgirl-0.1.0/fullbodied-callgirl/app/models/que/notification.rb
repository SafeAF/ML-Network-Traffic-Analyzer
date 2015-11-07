class Notification  < ActiveRecord::Base
	belongs_to :user
	belongs_to :machines
	belongs_to :cluster
	belongs_to :service
	belongs_to :application


end