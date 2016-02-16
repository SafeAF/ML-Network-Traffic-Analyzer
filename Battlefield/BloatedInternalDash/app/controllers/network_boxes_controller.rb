class NetworkBoxesController < ApplicationController
  before_action :set_network_box, only: [:show, :edit, :update, :destroy]

  # GET /network_boxes
  # GET /network_boxes.json
  def index
    @network_boxes = NetworkBox.all
  end

  # GET /network_boxes/1
  # GET /network_boxes/1.json
  def show
  end

  # GET /network_boxes/new
  def new
    @network_box = NetworkBox.new
  end

  # GET /network_boxes/1/edit
  def edit
  end

  # POST /network_boxes
  # POST /network_boxes.json
  def create
    @network_box = NetworkBox.new(network_box_params)

    respond_to do |format|
      if @network_box.save
        format.html { redirect_to @network_box, notice: 'Network box was successfully created.' }
        format.json { render :show, status: :created, location: @network_box }
      else
        format.html { render :new }
        format.json { render json: @network_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /network_boxes/1
  # PATCH/PUT /network_boxes/1.json
  def update
    respond_to do |format|
      if @network_box.update(network_box_params)
        format.html { redirect_to @network_box, notice: 'Network box was successfully updated.' }
        format.json { render :show, status: :ok, location: @network_box }
      else
        format.html { render :edit }
        format.json { render json: @network_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /network_boxes/1
  # DELETE /network_boxes/1.json
  def destroy
    @network_box.destroy
    respond_to do |format|
      format.html { redirect_to network_boxes_url, notice: 'Network box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network_box
      @network_box = NetworkBox.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def network_box_params
      params.require(:network_box).permit(:name, :hostname, :ip, :type, :manufacturer, :model, :router, :gateway, :network_id, :infrastructure_id, :gateway_ip, :os, :operations_id, :configuration)
    end
end
