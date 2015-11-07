class Devops  < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :services
	has_many :servers
	has_many :machines
	has_many :databases

	belongs_to :infrastructure
end