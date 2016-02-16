module Org
class Admin <  ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :managers
	belongs_to :infrastructure
	belongs_to :organization
end
	end