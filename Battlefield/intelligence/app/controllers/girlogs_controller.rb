class GirlogsController < ApplicationController
  before_action :set_girlog, only: [:show, :edit, :update, :destroy]

  # GET /girlogs
  # GET /girlogs.json
  def index
    @girlogs = Girlog.all
  end

  # GET /girlogs/1
  # GET /girlogs/1.json
  def show
  end

  # GET /girlogs/new
  def new
    @girlog = Girlog.new
  end

  # GET /girlogs/1/edit
  def edit
  end

  # POST /girlogs
  # POST /girlogs.json
  def create
    @girlog = Girlog.new(girlog_params)

    respond_to do |format|
      if @girlog.save
        format.html { redirect_to @girlog, notice: 'Girlog was successfully created.' }
        format.json { render :show, status: :created, location: @girlog }
      else
        format.html { render :new }
        format.json { render json: @girlog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /girlogs/1
  # PATCH/PUT /girlogs/1.json
  def update
    respond_to do |format|
      if @girlog.update(girlog_params)
        format.html { redirect_to @girlog, notice: 'Girlog was successfully updated.' }
        format.json { render :show, status: :ok, location: @girlog }
      else
        format.html { render :edit }
        format.json { render json: @girlog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /girlogs/1
  # DELETE /girlogs/1.json
  def destroy
    @girlog.destroy
    respond_to do |format|
      format.html { redirect_to girlogs_url, notice: 'Girlog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_girlog
      @girlog = Girlog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def girlog_params
      params.require(:girlog).permit(:name, :desc, :context, :component, :originator, :body, :generated_at, :application, :facility, :priority, :criticality, :error, :error_count, :response_time, :latency, :db_latency, :query_time, :query, :rows_count, :response_code, :http_code, :client, :user, :hostname, :pid, :program)
    end
end
