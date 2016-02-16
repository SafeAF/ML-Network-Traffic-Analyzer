class LogfilesController < ApplicationController
  before_action :set_logfile, only: [:show, :edit, :update, :destroy]

  # GET /logfiles
  # GET /logfiles.json
  def index
    @logfiles = Logfile.all
  end

  # GET /logfiles/1
  # GET /logfiles/1.json
  def show
  end

  # GET /logfiles/new
  def new
    @logfile = Logfile.new
  end

  # GET /logfiles/1/edit
  def edit
  end

  # POST /logfiles
  # POST /logfiles.json
  def create
    @logfile = Logfile.new(logfile_params)

    respond_to do |format|
      if @logfile.save
        format.html { redirect_to @logfile, notice: 'Logfile was successfully created.' }
        format.json { render :show, status: :created, location: @logfile }
      else
        format.html { render :new }
        format.json { render json: @logfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logfiles/1
  # PATCH/PUT /logfiles/1.json
  def update
    respond_to do |format|
      if @logfile.update(logfile_params)
        format.html { redirect_to @logfile, notice: 'Logfile was successfully updated.' }
        format.json { render :show, status: :ok, location: @logfile }
      else
        format.html { render :edit }
        format.json { render json: @logfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logfiles/1
  # DELETE /logfiles/1.json
  def destroy
    @logfile.destroy
    respond_to do |format|
      format.html { redirect_to logfiles_url, notice: 'Logfile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_logfile
      @logfile = Logfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def logfile_params
      params.require(:logfile).permit(:machine_id, :name, :description, :size, :entries, :entries_per_sec, :location, :path, :basename, :service, :service_id, :server_id, :criticality)
    end
end
