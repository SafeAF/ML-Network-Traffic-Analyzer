class Hardware  < ActiveRecord::Base
	belongs_to :user
	belongs_to :machines
	belongs_to :inventory
	belongs_to :operations

end