class Network < ActiveRecord::Base
	belongs_to :infrastructure
	has_many :machines
	belongs_to :cluster
	has_many :servers
	has_many :applications
	has_many :connections

end