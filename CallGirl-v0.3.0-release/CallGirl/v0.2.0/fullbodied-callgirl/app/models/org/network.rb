module Org

class Network < ActiveRecord::Base
	include Redis::Objects
	belongs_to :organization
	belongs_to :user
	belongs_to :manager
	has_many :privkeys
	has_many :pubkeys
	has_many :researches


	belongs_to :department
	belongs_to :infrastructure
	has_many :machines
	has_many :clusters
	has_many :servers
	has_many :applications
	has_many :connections

end
end
