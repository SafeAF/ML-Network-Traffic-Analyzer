class Api::NodesController < Api::ApiController

  def index
    Rails.logger.info "Current user: #{current_user.inspect}"
    render json: Node.all
  end

  def show
    node = current_user.nodes.find(params[:id])
    render json: node.as_json(include:[:nodes])
  end

  def create
    node = current_user.nodes.new(node_params)
    if node.save
      render status: 200, json: {
                            message: "Successfully created Node.",
                            node: node
                        }.to_json
    else
      render status: 422, json: {
                            errors: node.errors
                        }.to_json
    end
  end

  def update
    node = current_user.nodes.find(params[:id])
    if node.update(node_params)
      render status: 200, json: {
                            message: "Successfully updated",
                            node: node
                        }.to_json
    else
      render status: 422, json: {
                            errors: node.errors
                        }.to_json
    end
  end

  def destroy
    node = current_user.nodes.find(params[:id])
    node.destroy
    render status: 200, json: {
                          message: "Successfully deleted node."
                      }.to_json
  end

  private
  def node_params
    params.require("node").permit("title")
  end
end