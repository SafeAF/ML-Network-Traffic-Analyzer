
module Org
	class Credit < ActiveRecord::Base
		include Redis::Objects
		# technically don't really need an activerecord class if we are using redis to store
		# and we get the added bonus of atomic transactions with redis counters

		counter :total ## atomic, no assign only inc(5) dec(2) etc


		belongs_to :organization

		belongs_to :department

		belongs_to :operations
		has_many :datums
		belongs_to :user

	end

end