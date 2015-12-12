class IssuelistsController < ApplicationController
  before_action :set_issuelist, only: [:show, :edit, :update, :destroy]

  # GET /issuelists
  # GET /issuelists.json
  def index
    @issuelists = Issuelist.all
  end

  # GET /issuelists/1
  # GET /issuelists/1.json
  def show
  end

  # GET /issuelists/new
  def new
    @issuelist = Issuelist.new
  end

  # GET /issuelists/1/edit
  def edit
  end

  # POST /issuelists
  # POST /issuelists.json
  def create
    @issuelist = Issuelist.new(issuelist_params)

    respond_to do |format|
      if @issuelist.save
        format.html { redirect_to @issuelist, notice: 'Issuelist was successfully created.' }
        format.json { render :show, status: :created, location: @issuelist }
      else
        format.html { render :new }
        format.json { render json: @issuelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issuelists/1
  # PATCH/PUT /issuelists/1.json
  def update
    respond_to do |format|
      if @issuelist.update(issuelist_params)
        format.html { redirect_to @issuelist, notice: 'Issuelist was successfully updated.' }
        format.json { render :show, status: :ok, location: @issuelist }
      else
        format.html { render :edit }
        format.json { render json: @issuelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issuelists/1
  # DELETE /issuelists/1.json
  def destroy
    @issuelist.destroy
    respond_to do |format|
      format.html { redirect_to issuelists_url, notice: 'Issuelist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issuelist
      @issuelist = Issuelist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issuelist_params
      params.require(:issuelist).permit(:name, :description, :project_id)
    end
end
