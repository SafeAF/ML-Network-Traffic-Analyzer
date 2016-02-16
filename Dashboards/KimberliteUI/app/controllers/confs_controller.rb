class ConfsController < ApplicationController
roles :Admin, :User
  def edit
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:instance_id])
	@conf = @instance.conf
	@user.save!
  end

  def update
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:instance_id])
	@conf = @instance.conf
	@user.save!

    respond_to do |format|
      if @conf.update_attributes(conf_params)		#params[:conf])
		@conf.update_flag = 1
        flash[:notice] = "Instance #{@instance.human_name} was successfully updated."
        format.html { redirect_to(:controller => 'instances', :action=>'show',
						:machine_id => @machine.id, :id => @instance.id) }
        format.xml  { head :ok }
      else
        flash[:notice] = "Unable to process entry, please retry"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conf.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

protected

  def conf_params
    params.require(:conf).permit(:log_location, :error_log, :denyfile_location,
           :ban_duration, :pcap_filter, :pcap_location, :pcap_interface, :retry)
  end

end
