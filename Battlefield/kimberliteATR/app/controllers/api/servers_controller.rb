class Api::ServersController < Api::ApiController

  def index
    Rails.logger.info "Current user: #{current_user.inspect}"
    render json: Server.all
  end

  def show
    server = current_user.servers.find(params[:id])
    render json: server.as_json(include:[:servers])
  end

  def create
    server = current_user.servers.new(server_params)
    if server.save
      render status: 200, json: {
                            message: "Successfully created Server.",
                            server: server
                        }.to_json
    else
      render status: 422, json: {
                            errors: server.errors
                        }.to_json
    end
  end

  def update
    server = current_user.servers.find(params[:id])
    if server.update(server_params)
      render status: 200, json: {
                            message: "Successfully updated",
                            server: server
                        }.to_json
    else
      render status: 422, json: {
                            errors: server.errors
                        }.to_json
    end
  end

  def destroy
    server = current_user.servers.find(params[:id])
    server.destroy
    render status: 200, json: {
                          message: "Successfully deleted Server."
                      }.to_json
  end

  private
  def server_params
    params.require("server").permit("title")
  end
end