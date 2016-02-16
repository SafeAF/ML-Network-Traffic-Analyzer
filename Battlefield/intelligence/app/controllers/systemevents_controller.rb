class SystemeventsController < ApplicationController
  before_action :set_systemevent, only: [:show, :edit, :update, :destroy]

  # GET /systemevents
  # GET /systemevents.json
  def index
    @systemevents = Systemevent.all
  end

  # GET /systemevents/1
  # GET /systemevents/1.json
  def show
  end

  # GET /systemevents/new
  def new
    @systemevent = Systemevent.new
  end

  # GET /systemevents/1/edit
  def edit
  end

  # POST /systemevents
  # POST /systemevents.json
  def create
    @systemevent = Systemevent.new(systemevent_params)

    respond_to do |format|
      if @systemevent.save
        format.html { redirect_to @systemevent, notice: 'Systemevent was successfully created.' }
        format.json { render :show, status: :created, location: @systemevent }
      else
        format.html { render :new }
        format.json { render json: @systemevent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /systemevents/1
  # PATCH/PUT /systemevents/1.json
  def update
    respond_to do |format|
      if @systemevent.update(systemevent_params)
        format.html { redirect_to @systemevent, notice: 'Systemevent was successfully updated.' }
        format.json { render :show, status: :ok, location: @systemevent }
      else
        format.html { render :edit }
        format.json { render json: @systemevent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /systemevents/1
  # DELETE /systemevents/1.json
  def destroy
    @systemevent.destroy
    respond_to do |format|
      format.html { redirect_to systemevents_url, notice: 'Systemevent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_systemevent
      @systemevent = Systemevent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def systemevent_params
      params.require(:systemevent).permit(:Message, :Facility, :FromHost, :DeviceReportedTime, :ReceivedAt, :InfoUnitID, :SysLogTag)
    end
end
