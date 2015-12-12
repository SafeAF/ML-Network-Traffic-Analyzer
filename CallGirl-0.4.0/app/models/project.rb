class Project  < ActiveRecord::Base
	#has_and_belongs_to_many :users
	has_and_belongs_to_many :developers
	has_and_belongs_to_many :researchers
	has_and_belongs_to_many :applications
	has_many :tasklists
	has_many :issuelists
  belongs_to :user
 has_many :tasks
	belongs_to :infrastructure
end

