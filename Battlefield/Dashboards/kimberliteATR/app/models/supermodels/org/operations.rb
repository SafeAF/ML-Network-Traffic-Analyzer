module Org
class Operations  < ActiveRecord::Base
	belongs_to :organization
	has_many :users
	belongs_to :department

end
end
