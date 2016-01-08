class Logfile < ActiveRecord::Base
	belongs_to :machine
	has_many :logentries

end
