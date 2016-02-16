class EncryptedfilesController < ApplicationController
  before_action :set_encryptedfile, only: [:show, :edit, :update, :destroy]

  # GET /encryptedfiles
  # GET /encryptedfiles.json
  def index
    @encryptedfiles = Encryptedfile.all
  end

  # GET /encryptedfiles/1
  # GET /encryptedfiles/1.json
  def show
  end

  # GET /encryptedfiles/new
  def new
    @encryptedfile = Encryptedfile.new
  end

  # GET /encryptedfiles/1/edit
  def edit
  end

  # POST /encryptedfiles
  # POST /encryptedfiles.json
  def create
    @encryptedfile = Encryptedfile.new(encryptedfile_params)

    respond_to do |format|
      if @encryptedfile.save
        format.html { redirect_to @encryptedfile, notice: 'Encryptedfile was successfully created.' }
        format.json { render :show, status: :created, location: @encryptedfile }
      else
        format.html { render :new }
        format.json { render json: @encryptedfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /encryptedfiles/1
  # PATCH/PUT /encryptedfiles/1.json
  def update
    respond_to do |format|
      if @encryptedfile.update(encryptedfile_params)
        format.html { redirect_to @encryptedfile, notice: 'Encryptedfile was successfully updated.' }
        format.json { render :show, status: :ok, location: @encryptedfile }
      else
        format.html { render :edit }
        format.json { render json: @encryptedfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encryptedfiles/1
  # DELETE /encryptedfiles/1.json
  def destroy
    @encryptedfile.destroy
    respond_to do |format|
      format.html { redirect_to encryptedfiles_url, notice: 'Encryptedfile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encryptedfile
      @encryptedfile = Encryptedfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def encryptedfile_params
      params.require(:encryptedfile).permit(:name, :user_id, :server_id, :path, :vfilesystem_id, :privkey, :pubkey)
    end
end
