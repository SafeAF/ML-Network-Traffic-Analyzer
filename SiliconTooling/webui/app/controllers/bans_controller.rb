class BansController < ApplicationController

  def index
	@bans = Ban.find(:all)
  end

  def new
	@ban = Ban.new
  end

  def create
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:instance_id])
	@bans = Ban.find(:all)
	@ban = Ban.new(ban_params)		#params[:ban])
	@bans << @ban

    flash[:notice] = "Ban list for instance #{@instance.human_name} was successfully updated."
    respond_to do |format|
      format.html { redirect_to(:controller => 'bans', :action=>'manage', 
			:instance_id => @instance.id, :machine_id => @machine.id) }
      format.xml  { head :ok }
    end
  end

  def manage
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:instance_id])
	@bans = Ban.find(:all)
  end

  def edit
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:instance_id])
	@bans = Ban.find(:all)
	@ban = @bans.find(params[:id])
	@user.save!
  end

  def add
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:instance_id])
	@bans = Ban.find(:all)
	@ban = Ban.new(ban_params)				#params[:ban])
	@user.save!
  end

  def update
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:instance_id])
	@bans = Ban.find(:all)
	@ban = @bans.find(params[:ban][:id])
	@user.save!

    respond_to do |format|
      if @ban.update_attributes(params[:ban])
        flash[:notice] = "Ban list for instance #{@instance.human_name} was successfully updated."
        format.html { redirect_to(:controller => 'bans', 
			:action=>'manage', :instance_id => @instance.id,
			:machine_id => @machine.id) }
        format.xml  { head :ok }
      else
        flash[:notice] = "Unable to process entry, please retry"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ban.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  def destroy
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:instance_id])
	@ban = Bans.find(params[:id])
	@ban.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'bans', 
			:action=>'manage', :instance_id => @instance.id, 
			:machine_id => @machine.id) }
      format.xml  { head :ok }
    end
  end

protected

  def ban_params
    params.require(:ban).permit(:ip, :location, :reason, :duration, :gucid, :host_lookup)
  end
end
