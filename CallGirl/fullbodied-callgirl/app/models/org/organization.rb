module Org
class Organization < ActiveRecord::Base


	has_one :infrastructure
	has_many :clusters
	has_many :operations
	has_many :networks
	has_many :users
	has_many :machines
	has_many :servers

end

end
