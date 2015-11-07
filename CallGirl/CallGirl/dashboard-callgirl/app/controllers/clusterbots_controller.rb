class ClusterbotsController < ApplicationController
  before_action :set_clusterbot, only: [:show, :edit, :update, :destroy]

  # GET /clusterbots
  # GET /clusterbots.json
  def index
    @clusterbots = Clusterbot.all
  end

  # GET /clusterbots/1
  # GET /clusterbots/1.json
  def show
  end

  # GET /clusterbots/new
  def new
    @clusterbot = Clusterbot.new
  end

  # GET /clusterbots/1/edit
  def edit
  end

  # POST /clusterbots
  # POST /clusterbots.json
  def create
    @clusterbot = Clusterbot.new(clusterbot_params)

    respond_to do |format|
      if @clusterbot.save
        format.html { redirect_to @clusterbot, notice: 'Clusterbot was successfully created.' }
        format.json { render :show, status: :created, location: @clusterbot }
      else
        format.html { render :new }
        format.json { render json: @clusterbot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clusterbots/1
  # PATCH/PUT /clusterbots/1.json
  def update
    respond_to do |format|
      if @clusterbot.update(clusterbot_params)
        format.html { redirect_to @clusterbot, notice: 'Clusterbot was successfully updated.' }
        format.json { render :show, status: :ok, location: @clusterbot }
      else
        format.html { render :edit }
        format.json { render json: @clusterbot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clusterbots/1
  # DELETE /clusterbots/1.json
  def destroy
    @clusterbot.destroy
    respond_to do |format|
      format.html { redirect_to clusterbots_url, notice: 'Clusterbot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clusterbot
      @clusterbot = Clusterbot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clusterbot_params
      params.require(:clusterbot).permit(:name, :hostname, :ip, :cluster_id, :uptime, :configuration)
    end
end
