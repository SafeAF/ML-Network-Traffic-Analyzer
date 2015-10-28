module Org
class Research  < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :applications
	has_many :projects
	belongs_to :infrastructure
end
	end