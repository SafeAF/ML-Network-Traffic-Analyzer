module Org
	class Webserver
		belongs_to :server
		belongs_to :infrastructure
		belongs_to :organization
		belongs_to :user

		has_many :ips
		has_many :domains
		has_many :webpages
	end
end