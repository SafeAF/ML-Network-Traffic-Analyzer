module Org
class Infrastructure  < ActiveRecord::Base
	attr_accessor :status

	belongs_to :organization
	 has_many :clusters
   has_many :operations
	has_many :networks
	has_many :users
	has_many :machines
	has_many :servers
end
	end