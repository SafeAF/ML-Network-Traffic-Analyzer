module Callgirl
class Systemevent < ActiveRecord::Base
	include Redis::Objects

	list :latest
	list :all


end
	end