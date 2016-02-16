module Org
class Cluster  < ActiveRecord::Base
	belongs_to :manager
	belongs_to :user
	has_many :servers
	belongs_to :infrastructure
	belongs_to :organization
	has_many :machines
	belongs_to :network
	belongs_to :system

end
	end