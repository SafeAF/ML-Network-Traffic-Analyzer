class QuequesController < ApplicationController
  before_action :set_queque, only: [:show, :edit, :update, :destroy]

  # GET /queques
  # GET /queques.json
  def index
    @queques = Queque.all
  end

  # GET /queques/1
  # GET /queques/1.json
  def show
  end

  # GET /queques/new
  def new
    @queque = Queque.new
  end

  # GET /queques/1/edit
  def edit
  end

  # POST /queques
  # POST /queques.json
  def create
    @queque = Queque.new(queque_params)

    respond_to do |format|
      if @queque.save
        format.html { redirect_to @queque, notice: 'Queque was successfully created.' }
        format.json { render :show, status: :created, location: @queque }
      else
        format.html { render :new }
        format.json { render json: @queque.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /queques/1
  # PATCH/PUT /queques/1.json
  def update
    respond_to do |format|
      if @queque.update(queque_params)
        format.html { redirect_to @queque, notice: 'Queque was successfully updated.' }
        format.json { render :show, status: :ok, location: @queque }
      else
        format.html { render :edit }
        format.json { render json: @queque.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /queques/1
  # DELETE /queques/1.json
  def destroy
    @queque.destroy
    respond_to do |format|
      format.html { redirect_to queques_url, notice: 'Queque was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_queque
      @queque = Queque.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def queque_params
      params.require(:queque).permit(:name, :critlarm_id)
    end
end
