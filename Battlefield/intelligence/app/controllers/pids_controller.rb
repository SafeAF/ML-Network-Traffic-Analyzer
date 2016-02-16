class PidsController < ApplicationController
  before_action :set_pid, only: [:show, :edit, :update, :destroy]

  # GET /pids
  # GET /pids.json
  def index
    @pids = Pid.all
  end

  # GET /pids/1
  # GET /pids/1.json
  def show
  end

  # GET /pids/new
  def new
    @pid = Pid.new
  end

  # GET /pids/1/edit
  def edit
  end

  # POST /pids
  # POST /pids.json
  def create
    @pid = Pid.new(pid_params)

    respond_to do |format|
      if @pid.save
        format.html { redirect_to @pid, notice: 'Pid was successfully created.' }
        format.json { render :show, status: :created, location: @pid }
      else
        format.html { render :new }
        format.json { render json: @pid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pids/1
  # PATCH/PUT /pids/1.json
  def update
    respond_to do |format|
      if @pid.update(pid_params)
        format.html { redirect_to @pid, notice: 'Pid was successfully updated.' }
        format.json { render :show, status: :ok, location: @pid }
      else
        format.html { render :edit }
        format.json { render json: @pid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pids/1
  # DELETE /pids/1.json
  def destroy
    @pid.destroy
    respond_to do |format|
      format.html { redirect_to pids_url, notice: 'Pid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pid
      @pid = Pid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pid_params
      params.require(:pid).permit(:name, :pid, :process, :filehandles, :filehandle, :path, :proctime, :walltime, :io, :netio, :iowait, :memory, :machine_id, :server_id, :node_id, :network_id, :manager_id, :application_id, :service_id)
    end
end
