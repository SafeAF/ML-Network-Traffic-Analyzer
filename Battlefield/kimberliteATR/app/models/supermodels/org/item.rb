
module Org
	class Item  < ActiveRecord::Base
		include Redis::Objects
		belongs_to :organization
		belongs_to :infrastructure
		belongs_to :operations
		belongs_to :inventory
		belongs_to :department
		has_many :datums


	end

end