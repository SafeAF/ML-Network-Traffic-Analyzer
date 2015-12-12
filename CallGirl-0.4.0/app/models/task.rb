class Task  < ActiveRecord::Base
	include Redis::Objects
	belongs_to :tasklist
 has_many :labels

end
