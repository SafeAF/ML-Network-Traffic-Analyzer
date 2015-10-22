require 'activerecord'

class Node < ActiveRecord::Base
	belongs_to :machine
	belongs_to :server
	has_many :logentries

end
