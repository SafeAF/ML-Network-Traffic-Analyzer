require 'activerecord'

class Process < ActiveRecord::Base
	belongs_to :machine
	belongs_to :server

end
