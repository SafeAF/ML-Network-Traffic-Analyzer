class RejexesController < ApplicationController
  before_action :set_rejex, only: [:show, :edit, :update, :destroy]

  # GET /rejexes
  # GET /rejexes.json
  def index
    @rejexes = Rejex.all
  end

  # GET /rejexes/1
  # GET /rejexes/1.json
  def show
  end

  # GET /rejexes/new
  def new
    @rejex = Rejex.new
  end

  # GET /rejexes/1/edit
  def edit
  end

  # POST /rejexes
  # POST /rejexes.json
  def create
    @rejex = Rejex.new(rejex_params)

    respond_to do |format|
      if @rejex.save
        format.html { redirect_to @rejex, notice: 'Rejex was successfully created.' }
        format.json { render :show, status: :created, location: @rejex }
      else
        format.html { render :new }
        format.json { render json: @rejex.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rejexes/1
  # PATCH/PUT /rejexes/1.json
  def update
    respond_to do |format|
      if @rejex.update(rejex_params)
        format.html { redirect_to @rejex, notice: 'Rejex was successfully updated.' }
        format.json { render :show, status: :ok, location: @rejex }
      else
        format.html { render :edit }
        format.json { render json: @rejex.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rejexes/1
  # DELETE /rejexes/1.json
  def destroy
    @rejex.destroy
    respond_to do |format|
      format.html { redirect_to rejexes_url, notice: 'Rejex was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rejex
      @rejex = Rejex.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rejex_params
      params.require(:rejex).permit(:name, :description, :body, :flag, :flag2, :flag3, :flag4, :flag5, :flag6, :pattern, :pattern2, :substitute, :return_field, :return_field1, :return_field2, :return_field3, :return_field4, :serialized)
    end
end
