class Datastore2 < ActiveRecord::Base
	self.abstract_class = true

		 # include Redis::Objects

	## REPLACE  this with the appropriate database.yml
	establish_connection(	:adapter => 'mysql2',
	                       :host=> 'datastore2',
	                       :username=> 'callgirl',
	                       :password=> 'githerdunno',
	                       :database=> 'callgirl',)

	#self.table_name = 'SystemEvents'


	def self.search(query)
		where("message like ?", "%#{query}%")
	end

	protected



	private

end