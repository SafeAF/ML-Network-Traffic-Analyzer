module Org
	class Manager  < ActiveRecord::Base
		 include Redis::Objects
		belongs_to :user
		has_many :servers
		belongs_to :infrastructure
		belongs_to :organization
		has_many :clusters
		has_many :machines

	end
end