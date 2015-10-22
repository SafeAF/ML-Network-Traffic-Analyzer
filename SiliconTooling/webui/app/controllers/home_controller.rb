class HomeController < ApplicationController
#skip_before_filter :authenticate, :authorize

# use before_filter to get @user - make priv func
  # GET /machines
  # GET /machines.xml
  def index
   # @user = User.find(session[:user_id])
    @user = User.find(session[:user_id])
    @all_machines = @user.machines.all
    @machines = @user.machines.paginate(:page => params[:page], :per_page => 10)
   # @redis = Redis.current.info
    respond_to do |format|
      format.html # index.html.erb
    #  format.xml  { render :xml => @machines }
    end
  end
end
