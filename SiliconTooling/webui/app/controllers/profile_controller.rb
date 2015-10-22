$VERSION = '0.3.0'

class ProfileController < ApplicationController
  #backbone handles all the switchyard communications
  def new
    @user = User.new(params[:user])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def signup
    @user = User.new(params[:user])
    
   if request.post? 
   respond_to do |format|
	if @user.save_with_captcha
        format.html { redirect_to(:action => 'index', 
			:notice => 'User was successfully created.') }
		format.xml  { render :xml => @user, 
			:status => :created, :location => @user }

  	else 
#        format.html { redirect_to signup_url }
        format.html { render action: "signup" }
#:controller => 'profile', :action => "signup" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
	end
   end
  end
  end

  # just display the form and wait for user to
  # enter a name and password
  def login
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
		uri = session[:original_uri]
		session[:original_uri] = nil
        redirect_to(uri || {:action => "index"})
#  		redirect_to(:action => "index")
      else
        flash.now[:notice] = "Invalid user/password combination -" +
							" Contact customer support for password recovery"
      end
    end
  end
  
#roles :User, :Admin
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end  

  def edit
    @user = User.find(session[:user_id])
    if request.post?
    	respond_to do |format|
			if @user.update_attributes(params[:user])
				flash[:notice] = "Profile for #{@user.username} successfully updated."
				format.html {redirect_to(:controller=>'profile', :action=>'index')}
				format.xml { head :ok }
			else
				format.html {redirect_to(:controller=>'profile', :action=>'index')}
				format.xml {render :xml => @user.errors,
					:status => :unprocessable_entity }
			end
		end
    end
  end

  def change_password
    @user = User.find(session[:user_id])
    if request.post?
	@user = User.authenticate(params[:username], params[:password])
	if @user
  	  if params[:new_password] == params[:password_confirmation]
  	    if @user.password=(params[:new_password])
	  	@user.save
    		flash.now[:notice] = "Password for #{@user.username} changed"
  	    else
		flash.now[:notice] = "Password not changed"
	    end
  	  else
  		flash.now[:notice] = "Confirmed password does not match"
     	  end 
	else
		flash[:notice] = "Invalid user/password combination"
		redirect_to(:action => "login")
	end
    end
  end

	def index
	@user = User.find(session[:user_id])

	# Populate Assets Monitored data
	@machine_sums = {:total => @user.machines.count, :running => 0, :down => 0 }
	@instance_sums = {:total => 0, :running => 0, :down => 0 }
	@user.machines.all.each {|machine|
		@instance_sums[:total] += machine.instances.count
		next if machine.alive.nil?
		if (machine.alive.utc > (Time.now.utc - (5 * 60)))
			@machine_sums[:running] += 1
		end
		machine.instances.find(:all).each {|instance|
			next if instance.alive.nil?
			if (instance.alive.utc > (Time.now.utc - (5 * 60)))
				@instance_sums[:running] += 1
			end
		}
	}
	@machine_sums[:down] = @machine_sums[:total] - @machine_sums[:running]
	@instance_sums[:down] = @instance_sums[:total] - @instance_sums[:running]

#	@instance_sums = {:total => Instance.count, :running => 0, :down => 0 }
#	Machine.find(:all).each {|machine|
#		next if machine.alive.nil?
#		if (machine.alive.utc > (Time.now.utc - (5 * 60)))
#			@machine_sums[:running] += 1
#		end
#		}

#	Instance.find(:all).each {|instance|
#		next if instance.alive.nil?
#		if (instance.alive.utc > (Time.now.utc - (5 * 60)))
#			@instance_sums[:running] += 1
#		end
#		}
	end


private 



end
