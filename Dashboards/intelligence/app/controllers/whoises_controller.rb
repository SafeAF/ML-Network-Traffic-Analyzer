class WhoisesController < ApplicationController
  before_action :set_whoise, only: [:show, :edit, :update, :destroy]

  # GET /whoises
  # GET /whoises.json
  def index
    @whoises = Whoise.all
  end

  # GET /whoises/1
  # GET /whoises/1.json
  def show
  end

  # GET /whoises/new
  def new
    @whoise = Whoise.new
  end

  # GET /whoises/1/edit
  def edit
  end

  # POST /whoises
  # POST /whoises.json
  def create
    @whoise = Whoise.new(whoise_params)

    respond_to do |format|
      if @whoise.save
        format.html { redirect_to @whoise, notice: 'Whoise was successfully created.' }
        format.json { render :show, status: :created, location: @whoise }
      else
        format.html { render :new }
        format.json { render json: @whoise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /whoises/1
  # PATCH/PUT /whoises/1.json
  def update
    respond_to do |format|
      if @whoise.update(whoise_params)
        format.html { redirect_to @whoise, notice: 'Whoise was successfully updated.' }
        format.json { render :show, status: :ok, location: @whoise }
      else
        format.html { render :edit }
        format.json { render json: @whoise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /whoises/1
  # DELETE /whoises/1.json
  def destroy
    @whoise.destroy
    respond_to do |format|
      format.html { redirect_to whoises_url, notice: 'Whoise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_whoise
      @whoise = Whoise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def whoise_params
      params.require(:whoise).permit(:url_id, :hostname, :ip, :ip_id, :content, :last_crawled)
    end
end
