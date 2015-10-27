class Critlarm  < ActiveRecord::Base
	include Redis::Objects

	list :messageq

	has_many :queques

end
