
class Systemlog < ActiveRecord::Base
	#  include Redis::Objects

	## REPLACE  this with the appropriate database.yml
	establish_connection(  :adapter => 'mysql2',
	                       :host=> 'datastore2',
	                       :username=> 'rsyslog',
	                       :password=> 'bigrsyslogpasswordforsure',
	                       :database=> 'rsyslog',)

	self.table_name = 'SystemEvents'


	def self.search(query)
		where("message like ?", "%#{query}%")
	end

	protected



	private

end

