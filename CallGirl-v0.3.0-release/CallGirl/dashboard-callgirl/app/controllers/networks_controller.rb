class NetworksController < ApplicationController
		before_action :set_network, only: [:show, :edit, :update, :destroy]

		# GET /mainframes
		# GET /mainframes.json
		def index
			@network = Network.all
		end

		# GET /mainframes/1
		# GET /mainframes/1.json
		def show
		end

		# GET /mainframes/new
		def new
			@network = Network.new
		end

		# GET /mainframes/1/edit
		def edit
		end

		# POST /mainframes
		# POST /mainframes.json
		def create
			@network = Network.new(network_params)

			respond_to do |format|
				if @network.save
					format.html { redirect_to @network, notice: 'network was successfully created.' }
					format.json { render :show, status: :created, location: @network }
				else
					format.html { render :new }
					format.json { render json: @network.errors, status: :unprocessable_entity }
				end
			end
		end

		# PATCH/PUT /mainframes/1
		# PATCH/PUT /mainframes/1.json
		def update
			respond_to do |format|
				if @network.update(network_params)
					format.html { redirect_to @network, notice: 'network was successfully updated.' }
					format.json { render :show, status: :ok, location: @network }
				else
					format.html { render :edit }
					format.json { render json: @network.errors, status: :unprocessable_entity }
				end
			end
		end

		# DELETE /mainframes/1
		# DELETE /mainframes/1.json
		def destroy
			@netname = @network.name
			@network.destroy
			respond_to do |format|
				format.html { redirect_to networks_url, notice: "Network #{@netname} was successfully destroyed." }
				format.json { head :no_content }
			end
		end

		private
		# Use callbacks to share common setup or constraints between actions.
		def set_network
			@network = network.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def network_params                     ## TODO Fix these params to match network
			params.require(:network).permit(:system, :name, :ghz, :gflops)
		end
	end

