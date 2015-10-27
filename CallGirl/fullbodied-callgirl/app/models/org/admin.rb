class Admin <  ActiveRecord::Base
	has_and_belongs_to_many :managers
	has_one :infrastructure
end