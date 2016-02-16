module Org
	class Ip < ActiveRecord::Base
		belongs_to :organization
		belongs_to :infrastructure
		belongs_to :server
		has_many :webpages
		belongs_to :webserver
		has_and_belongs_to_many :domains
	end
end