module Org
	class Whois < ActiveRecord::Base
		belongs_to :organization
		belongs_to :infrastructure
		has_many :webpages
		belongs_to :domain
		belongs_to :ip
	end
end