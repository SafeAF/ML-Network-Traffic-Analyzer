#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
class UsersController < ApplicationController
skip_before_filter :authenticate, :authorize

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users
  # GET /users.xml
  def index
    @user = User.find(session[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml


  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(user_params)			#params[:user])
	# Give user their role
	@user.roles << Role.find(:first, :conditions => ["name = ?", "User"])
#	@user.save_with_captcha

    respond_to do |format|
      if @user.save_with_captcha
        flash[:notice] = "User #{@user.name} was successfully created."
        format.html { redirect_to(:controller => 'profile', :action=>'index') }
        format.xml  { render :xml => @user, :status => :created,
                             :location => @user }
      else
        #format.html { redirect_to :back } #signup_path }
	format.html { render 'profile/signup'  }   # Trying to fix redirect so errors are displayed in signup
#render :action => "new" }
        format.xml  { render :xml => @user.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)				#params[:user])
        flash[:notice] = "User #{@user.name} was successfully updated."
        format.html { redirect_to(:controller => 'profile', :action=>'index') }
        format.xml  { head :ok }
      else
        format.html { redirect_to(:controller => 'profile', :action=>'edit') }#render  :action => "edit" }
        format.xml  { render :xml => @user.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'home') }
      format.xml  { head :ok }
    end
  end

protected

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :fullname,
        :email, :company, :address1, :address2, :city, :state, :zip,
        :country, :phone, :captcha, :captcha_key)
  end
end
