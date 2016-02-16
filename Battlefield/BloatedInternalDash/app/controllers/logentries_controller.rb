class LogentriesController < ApplicationController
  before_action :set_logentry, only: [:show, :edit, :update, :destroy]

  # GET /logentries
  # GET /logentries.json
  def index
    @logentries = Logentry.all
  end

  # GET /logentries/1
  # GET /logentries/1.json
  def show
  end

  # GET /logentries/new
  def new
    @logentry = Logentry.new
  end

  # GET /logentries/1/edit
  def edit
  end

  # POST /logentries
  # POST /logentries.json
  def create
    @logentry = Logentry.new(logentry_params)

    respond_to do |format|
      if @logentry.save
        format.html { redirect_to @logentry, notice: 'Logentry was successfully created.' }
        format.json { render :show, status: :created, location: @logentry }
      else
        format.html { render :new }
        format.json { render json: @logentry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logentries/1
  # PATCH/PUT /logentries/1.json
  def update
    respond_to do |format|
      if @logentry.update(logentry_params)
        format.html { redirect_to @logentry, notice: 'Logentry was successfully updated.' }
        format.json { render :show, status: :ok, location: @logentry }
      else
        format.html { render :edit }
        format.json { render json: @logentry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logentries/1
  # DELETE /logentries/1.json
  def destroy
    @logentry.destroy
    respond_to do |format|
      format.html { redirect_to logentries_url, notice: 'Logentry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_logentry
      @logentry = Logentry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def logentry_params
      params.require(:logentry).permit(:logfile_id, :name, :message, :facility, :priority, :logged_at, :service, :service_id, :logentry_id)
    end
end
