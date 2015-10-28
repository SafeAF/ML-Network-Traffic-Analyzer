
module Org
class Inventory  < ActiveRecord::Base
	include Redis::Objects
	belongs_to :organization
belongs_to :infrastructure
	belongs_to :operations
	has_many :items
	has_many :hardwares
	belongs_to :department
	has_many :credits
	has_many :datums


end

	end