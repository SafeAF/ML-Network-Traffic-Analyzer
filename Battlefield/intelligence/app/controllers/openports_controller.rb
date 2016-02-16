class OpenportsController < ApplicationController
  before_action :set_openport, only: [:show, :edit, :update, :destroy]

  # GET /openports
  # GET /openports.json
  def index
    @openports = Openport.all
  end

  # GET /openports/1
  # GET /openports/1.json
  def show
  end

  # GET /openports/new
  def new
    @openport = Openport.new
  end

  # GET /openports/1/edit
  def edit
  end

  # POST /openports
  # POST /openports.json
  def create
    @openport = Openport.new(openport_params)

    respond_to do |format|
      if @openport.save
        format.html { redirect_to @openport, notice: 'Openport was successfully created.' }
        format.json { render :show, status: :created, location: @openport }
      else
        format.html { render :new }
        format.json { render json: @openport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /openports/1
  # PATCH/PUT /openports/1.json
  def update
    respond_to do |format|
      if @openport.update(openport_params)
        format.html { redirect_to @openport, notice: 'Openport was successfully updated.' }
        format.json { render :show, status: :ok, location: @openport }
      else
        format.html { render :edit }
        format.json { render json: @openport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /openports/1
  # DELETE /openports/1.json
  def destroy
    @openport.destroy
    respond_to do |format|
      format.html { redirect_to openports_url, notice: 'Openport was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_openport
      @openport = Openport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def openport_params
      params.require(:openport).permit(:name, :desc, :port, :ip_id, :service_id, :network_id)
    end
end
