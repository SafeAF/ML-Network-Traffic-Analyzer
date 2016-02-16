class Task  < ActiveRecord::Base
	include Redis::Objects
	belongs_to :project
end
