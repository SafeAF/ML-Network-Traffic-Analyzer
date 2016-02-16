class Api::ServicesController < Api::ApiController
  before_filter :find_server

  def create
    service = @server.services.new(service_params)
    if service.save
      render status: 200, json: {
                            message: "Successfully created Service.",
                            server: @server,
                            service: service
                        }.to_json
    else
      render status: 422, json: {
                            message: "Service creation failed.",
                            errors: service.errors
                        }.to_json
    end
  end


  def update
    service = @server.services.find(params[:id])
    if service.update(service_params)
      render status: 200, json: {
                            message: "Successfully updated Service.",
                            server: @server,
                            service: service
                        }.to_json
    else
      render status: 422, json: {
                            message: "Service update failed.",
                            errors: service.errors
                        }.to_json
    end
  end

  def destroy
    service = @server.services.find(params[:id])
    service.destroy
    render status: 200, json: {
                          message: "Service successfully deleted.",
                          server: @server,
                          service: service
                      }.to_json
  end

  private

  def find_server
    @server = current_user.servers.find(params[:server_id])
  end

  def set_service
    @service = Service.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def service_params
    params.require(:service).permit(:name, :description, :type, :location, :webserver_id, :distribution, :cluster, :replication, :authority, :purpose, :watchdog, :pid, :criticality, :priority, :configuration)
  end
end