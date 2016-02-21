class Project  < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :developers
	has_and_belongs_to_many :researchers
	has_and_belongs_to_many :applications

	belongs_to :infrastructure
end
