class PubserversController < ApplicationController
  before_action :set_pubserver, only: [:show, :edit, :update, :destroy]

  # GET /pubservers
  # GET /pubservers.json
  def index
    @pubservers = Pubserver.all
  end

  # GET /pubservers/1
  # GET /pubservers/1.json
  def show
  end

  # GET /pubservers/new
  def new
    @pubserver = Pubserver.new
  end

  # GET /pubservers/1/edit
  def edit
  end

  # POST /pubservers
  # POST /pubservers.json
  def create
    @pubserver = Pubserver.new(pubserver_params)

    respond_to do |format|
      if @pubserver.save
        format.html { redirect_to @pubserver, notice: 'Pubserver was successfully created.' }
        format.json { render :show, status: :created, location: @pubserver }
      else
        format.html { render :new }
        format.json { render json: @pubserver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pubservers/1
  # PATCH/PUT /pubservers/1.json
  def update
    respond_to do |format|
      if @pubserver.update(pubserver_params)
        format.html { redirect_to @pubserver, notice: 'Pubserver was successfully updated.' }
        format.json { render :show, status: :ok, location: @pubserver }
      else
        format.html { render :edit }
        format.json { render json: @pubserver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pubservers/1
  # DELETE /pubservers/1.json
  def destroy
    @pubserver.destroy
    respond_to do |format|
      format.html { redirect_to pubservers_url, notice: 'Pubserver was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pubserver
      @pubserver = Pubserver.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pubserver_params
      params.require(:pubserver).permit(:name, :ip, :hostname, :os, :dns, :whois, :organization, :organization_id, :reputation_id, :url, :applications, :application_id, :service_id, :app_version, :webserver, :webserver_id, :webserver_version)
    end
end
