require 'rye'
class ServersController < ApplicationController
  before_action :set_server, only: [:show, :edit, :update, :destroy]

  # GET /servers
  # GET /servers.json
  def index
    #@servers = Server.all
    @user = User.find(current_user)
    @search = @user.servers.search(params[:q])
    @servers = @search.result.paginate(:page => params[:page], :per_page => 20)


  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @user = User.find(current_user)
    @server = @user.servers.find(params[:id])
    @serverConnection = Rye::Box.new(hostname, :safe => false)
  end

  # GET /servers/new
  def new
    @server = Server.new
  end

  # GET /servers/1/edit
  def edit
   # @user = User.find(current_user)
   # @server = @user.servers.find(params[:id])
    @user.save!
  end

  # POST /servers
  # POST /servers.json
  def create
    @user = User.find(current_user)
    @server = Server.new(server_params)
    @user.servers << @server
    @user.save!

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
        format.json { render :show, status: :created, location: @server }
      else
        format.html { render :new }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servers/1
  # PATCH/PUT /servers/1.json
  def update
  #  @user = User.find(current_user)
   # @server = @user.servers.find(params[:id])
    @user.save!

    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { render :show, status: :ok, location: @server }
      else
        format.html { render :edit }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
   # @user = User.find(current_user)
   # @server = @user.servers.find(params[:id])
    @server.destroy

    respond_to do |format|
      format.html { redirect_to servers_url, notice: 'Server was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_server
   #   @server = Server.find(params[:id])
      @user = User.find(current_user)
      @server = @user.servers.find(params[:id])
      @srv = Rye::Box.new(hostname, :safe => false)
      @server.uptime = nil
      Thread.new { @server.uptime = @srv.uptime }
      if @server.uptime.nil?
        @server.uptime = 'DOWN'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def server_params
      params.require(:server).permit(:name, :username,  :password, :privkey, :pubkey, :key, :ip, :hostname,  :ipaddr, :string, :machine_id, :cluster_id, :virtual?, :up?, :criticality, :priority, :network_id, :manager_id, :os, :devops_id, :uptime, :system_id, :user_id, :configuration)
    end
end
