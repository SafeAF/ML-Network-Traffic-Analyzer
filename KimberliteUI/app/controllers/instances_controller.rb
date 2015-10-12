require 'digest/sha1'

class InstancesController < ApplicationController
	#before_filter :bans_today
roles :User, :Admin
  def bans_today
	@bans_today = Ban.created_after(Time.now.utc-1.day).count	
  end

  def index
	@user = User.find(session[:user_id])
	@machine = @user.machines.find(params[:machine_id])
	#@instances = @machine.instances.find(:all)
	@instances = @machine.instances.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @instances }
    end
  end

  def show
	@user = User.find(session[:user_id])
	@machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:id])
	@conf = @instance.conf

#	flash[:notice] = @conf.delay

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @instance }
    end
  end

  def new
	@user = User.find(session[:user_id])
	@machine = @user.machines.find(params[:machine_id])
    @instance = Instance.new(instance_params)					#params[:instance])
	@types = ['ssh', 'apache']
	# set pcap filter string based on service types
  end

  # GET /users/1/edit
  def edit
	@user = User.find(session[:user_id])
	@machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:id])
	@types = ['ssh', 'apache']
	#@bans =	 @instance.bans
	#@conf = @instance.conf
	@user.save!
  end

  def create
	@user = User.find(session[:user_id])
	@machine = @user.machines.find(params[:machine_id])

	@instance = Instance.new(instance_params)			#params[:instance])
	@instance.gucid = Instance.generate_gucid(params[:instance][:instance_type], 
						@instance)
	@instance.conf = Conf.new
    @machine.instances << @instance
 	@user.save!

    flash[:notice] = "Instance #{@instance.human_name} was successfully created."
    respond_to do |format|
      format.html { redirect_to(:action=>'index', :machine_id=>@machine.id) }
      format.xml  { head :ok }
	end

  end

  def update
	@user = User.find(session[:user_id])
	@machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:id])
	#@bans =	 @instance.bans
	#@conf = @instance.conf
	@user.save!

    respond_to do |format|
      if @instance.update_attributes(instance_params)			#params[:instance])
        flash[:notice] = "Instance #{@instance.human_name} was successfully updated."
        format.html { redirect_to(:action=>'index', :machine_id => @machine.id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @instance.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  def destroy
	# destroy should also wipe out instance on client
	# bans and conf should be dependent and get destroyed also
	@user = User.find(session[:user_id])
	@machine = @user.machines.find(params[:machine_id])
	@instance = @machine.instances.find(params[:id])
	m = Message.new
	m.message = '::DELETE==' + @instance.gucid
	@instance.messages << m
	@instance.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'instances',
			:action => 'index', :id => @instance.id,
			:machine_id => @machine.id) }
      format.xml  { head :ok }
    end
  end

protected

  def instance_params
    params.require(:instance).permit(:instance_type, :human_name, :description, :gucid) if params[:instance]
  end

private

  def generate_gucid(type, obj)
	n = obj.object_id ^ Time.now.to_i
	hash = Digest::SHA1.hexdigest(n.to_s)
	hash = type.upcase + "_" + hash
  end

end
