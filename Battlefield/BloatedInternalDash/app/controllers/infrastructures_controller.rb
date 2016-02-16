class InfrastructuresController < ApplicationController
  before_action :set_infrastructure, only: [:show, :edit, :update, :destroy]

  # GET /infrastructures
  # GET /infrastructures.json
  def index
    @infrastructures = Infrastructure.all
  end

  # GET /infrastructures/1
  # GET /infrastructures/1.json
  def show
  end

  # GET /infrastructures/new
  def new
    @infrastructure = Infrastructure.new
  end

  # GET /infrastructures/1/edit
  def edit
  end

  # POST /infrastructures
  # POST /infrastructures.json
  def create
    @infrastructure = Infrastructure.new(infrastructure_params)

    respond_to do |format|
      if @infrastructure.save
        format.html { redirect_to @infrastructure, notice: 'Infrastructure was successfully created.' }
        format.json { render :show, status: :created, location: @infrastructure }
      else
        format.html { render :new }
        format.json { render json: @infrastructure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /infrastructures/1
  # PATCH/PUT /infrastructures/1.json
  def update
    respond_to do |format|
      if @infrastructure.update(infrastructure_params)
        format.html { redirect_to @infrastructure, notice: 'Infrastructure was successfully updated.' }
        format.json { render :show, status: :ok, location: @infrastructure }
      else
        format.html { render :edit }
        format.json { render json: @infrastructure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infrastructures/1
  # DELETE /infrastructures/1.json
  def destroy
    @infrastructure.destroy
    respond_to do |format|
      format.html { redirect_to infrastructures_url, notice: 'Infrastructure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_infrastructure
      @infrastructure = Infrastructure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def infrastructure_params
      params.require(:infrastructure).permit(:name, :purpose, :description, :type, :effectiveness, :utilization, :return_on_assets, :manhours_per_unit_production, :revenue_per_employee, :organizational_unit, :total_klocs, :klocs_ytd, :total_manhours, :manhours_this_month, :manhours_last_month, :average_manhours, :bugs_this_month, :bugs_last_month, :average_bugs_month, :klocs_this_month, :klocs_last_month, :average_klocs_month, :klocs_per_manhour, :bugs_per_kloc, :defect_removal_rate, :service, :application, :cluster_id, :user_id, :criticality, :network, :admin_id, :operations_id)
    end
end
