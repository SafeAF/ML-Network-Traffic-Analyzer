class LoggingController < ApplicationController
	def index
		@user = User.find(session[:user_id])
		@all_machines = @user.machines.all
		@all_machines.each {|m| m.logfiles }
	end
end
