class Inventory  < ActiveRecord::Base
	include Redis::Objects
belongs_to :infrastructure
	belongs_to :operations
	has_many :items
	has_many :hardwares

end