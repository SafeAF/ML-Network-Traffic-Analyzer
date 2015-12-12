class ConnectionController < ApplicationController

	def change_connection(parameters)
		ActiveRecord::Base.establish_connection(
				:adapter  => parameters[:adapter],
				:host     => parameters[:host],
				:username => parameters[:username],
				:password => parameters[:password],
				:database => parameters[:database]
		)
		end
end
