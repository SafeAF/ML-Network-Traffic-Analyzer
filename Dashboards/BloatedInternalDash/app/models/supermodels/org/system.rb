module Org
class System  < ActiveRecord::Base
	include Redis::Objects

	belongs_to :cluster
	has_many :servers
	belongs_to :infrastructure


end
	end