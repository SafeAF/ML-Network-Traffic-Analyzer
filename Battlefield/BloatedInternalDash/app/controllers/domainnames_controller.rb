class DomainnamesController < ApplicationController
  before_action :set_domainname, only: [:show, :edit, :update, :destroy]

  # GET /domainnames
  # GET /domainnames.json
  def index
    @domainnames = Domainname.all
  end

  # GET /domainnames/1
  # GET /domainnames/1.json
  def show
  end

  # GET /domainnames/new
  def new
    @domainname = Domainname.new
  end

  # GET /domainnames/1/edit
  def edit
  end

  # POST /domainnames
  # POST /domainnames.json
  def create
    @domainname = Domainname.new(domainname_params)

    respond_to do |format|
      if @domainname.save
        format.html { redirect_to @domainname, notice: 'Domainname was successfully created.' }
        format.json { render :show, status: :created, location: @domainname }
      else
        format.html { render :new }
        format.json { render json: @domainname.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /domainnames/1
  # PATCH/PUT /domainnames/1.json
  def update
    respond_to do |format|
      if @domainname.update(domainname_params)
        format.html { redirect_to @domainname, notice: 'Domainname was successfully updated.' }
        format.json { render :show, status: :ok, location: @domainname }
      else
        format.html { render :edit }
        format.json { render json: @domainname.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domainnames/1
  # DELETE /domainnames/1.json
  def destroy
    @domainname.destroy
    respond_to do |format|
      format.html { redirect_to domainnames_url, notice: 'Domainname was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domainname
      @domainname = Domainname.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domainname_params
      params.require(:domainname).permit(:ip_id, :cname, :aname, :mx, :mx2, :mx3, :mx4, :hostname, :reverse_lookup, :location, :isp, :organisation_id, :network_id, :server_id, :nameserver1, :nameserver2)
    end
end
