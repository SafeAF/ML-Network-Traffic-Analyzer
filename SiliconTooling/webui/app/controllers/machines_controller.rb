class MachinesController < ApplicationController
# use before_filter to get @user - make priv func
#roles :User, :Admin ## FIXME for rights and roles

  ## setup before filter FIXME
  # GET /machines
  # GET /machines.xml
  def index
	@user = User.find(session[:user_id])
    #@machines = @user.machines.find(:all)
    @machines = @user.machines.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @machines }
    end
  end

  # GET /machines/1
  # GET /machines/1.xml
  def show
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:id])
	@instances = @machine.instances.find(:all)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @machine }
    end
  end

  def search
	@user = User.find(session[:user_id])
    @machines = @user.machines.find(:all)
  end

  # GET /machines/new
  # GET /machines/new.xml
  def new
    @machine = Machine.new(machine_params)		#params[:machine])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @machine }
    end
  end

  # GET /machines/1/edit
  def edit
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:id])
	@user.save!
  end

  # POST /machines
  # POST /machines.xml
  def create
	@user = User.find(session[:user_id])
    @machine = Machine.new(machine_params)		#params[:machine])
	@user.machines << @machine
	@user.save!

    respond_to do |format|
      if @machine.save
        format.html { redirect_to(:action => 'index', :notice => 'Machine was successfully created.') }
        format.xml  { render :xml => @machine, :status => :created, :location => @machine }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @machine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /machines/1
  # PUT /machines/1.xml
  def update
	@user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:id])
	@user.save!

    respond_to do |format|
      if @machine.update_attributes(machine_params)			#params[:machine])
        format.html { redirect_to(:action => 'index', :notice => 'Machine was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @machine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.xml
  def destroy
	@user = User.find(session[:user_id])
    @machine =  @user.machines.find(params[:id])
    @machine.destroy

    respond_to do |format|
      format.html { redirect_to(machines_url) }
      format.xml  { head :ok }
    end
  end

protected

  def machine_params
    params.require(:machine).permit(:name, :hostname, :ip, :cid) if params[:machine]
  end
end
