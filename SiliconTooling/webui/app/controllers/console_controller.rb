class ConsoleController < ApplicationController
roles :User, :Admin
  def open

  end


	#tokenize & parse @input and spec functionality 
  def terminal
	@input = params[:input]
	if @input == 'show machines'
		@user = User.find(session[:user_id])
   		@machines = @user.machines.find(:all)
		@output = @machines.collect { |m| m.hostname}.join('<br/>')

	elsif @input == 'show instances'
		@user = User.find(session[:user_id])
   		@machines = @user.machines.find(:all)
		@instances = @machines.collect {|m| m.instances}
		@output = @instances.collect { |i| i.name }.join('<br/>')		

	elsif @input == 'create machine'
		@user = User.find(session[:user_id])
	    @machine = Machine.new(params[:machine])
		@user.machines << @machine
		@user.save!
		@output = @machine.id


	elsif (@input =~ /sh|esh|\/bin\/e?sh\/?|\/bin\/bash/)
		@output = "/bin/esh"
	
	
	elsif @input == 'date'
		@output = Time.now

	elsif @input == 'id'
			@user = User.find(session[:user_id])
			@output = ["id=", @user.id, " ", "username=", @user.name].join("")

	elsif @input == 'help'
		@output = "Esh Help\n" + 
					"----------\n" +
					"show machines - list registered machines\n" +
					"show instances - list registered instances\n" +
					"create machine - creates a new machine\n" +
					"date - show the current date and time\n" +
					"id - show current user information\n" 
	end
	
  end

end
