class CritlarmsController < ApplicationController
  before_action :set_critlarm, only: [:show, :edit, :update, :destroy]

  # GET /critlarms
  # GET /critlarms.json
  def index
    @critlarms = Critlarm.all
  end

  # GET /critlarms/1
  # GET /critlarms/1.json
  def show
  end

  # GET /critlarms/new
  def new
    @critlarm = Critlarm.new
  end

  # GET /critlarms/1/edit
  def edit
  end

  # POST /critlarms
  # POST /critlarms.json
  def create
    @critlarm = Critlarm.new(critlarm_params)

    respond_to do |format|
      if @critlarm.save
        format.html { redirect_to @critlarm, notice: 'Critlarm was successfully created.' }
        format.json { render :show, status: :created, location: @critlarm }
      else
        format.html { render :new }
        format.json { render json: @critlarm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /critlarms/1
  # PATCH/PUT /critlarms/1.json
  def update
    respond_to do |format|
      if @critlarm.update(critlarm_params)
        format.html { redirect_to @critlarm, notice: 'Critlarm was successfully updated.' }
        format.json { render :show, status: :ok, location: @critlarm }
      else
        format.html { render :edit }
        format.json { render json: @critlarm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /critlarms/1
  # DELETE /critlarms/1.json
  def destroy
    @critlarm.destroy
    respond_to do |format|
      format.html { redirect_to critlarms_url, notice: 'Critlarm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_critlarm
      @critlarm = Critlarm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def critlarm_params
      params.require(:critlarm).permit(:name, :heading, :content, :body, :source, :destination, :pos_in_queque, :tied_to_ui_component, :populates_widget)
    end
end
