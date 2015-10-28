module Serv
class Logentry < ActiveRecord::Base
	belongs_to :logfile
end
	end