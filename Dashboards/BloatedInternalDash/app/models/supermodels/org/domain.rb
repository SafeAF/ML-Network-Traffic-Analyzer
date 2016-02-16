module Org
	class Domain < ActiveRecord::Base
		belongs_to :organization
		belongs_to :infrastructure
		has_many :webpages
		belongs_to :webserver
		has_and_belongs_to_many :ips
	end
end