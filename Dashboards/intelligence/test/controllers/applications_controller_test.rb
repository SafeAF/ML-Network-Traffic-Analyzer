require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  setup do
    @application = applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application" do
    assert_difference('Application.count') do
      post :create, application: { criticality: @application.criticality, description: @application.description, developer_id: @application.developer_id, hostname: @application.hostname, machine_id: @application.machine_id, manager_id: @application.manager_id, name: @application.name, network: @application.network, network_id: @application.network_id, node_id: @application.node_id, notice: @application.notice, parent_process: @application.parent_process, priority: @application.priority, process_id: @application.process_id, pubserver_id: @application.pubserver_id, purpose: @application.purpose, server_id: @application.server_id, service: @application.service, status: @application.status, user_id: @application.user_id }
    end

    assert_redirected_to application_path(assigns(:application))
  end

  test "should show application" do
    get :show, id: @application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @application
    assert_response :success
  end

  test "should update application" do
    patch :update, id: @application, application: { criticality: @application.criticality, description: @application.description, developer_id: @application.developer_id, hostname: @application.hostname, machine_id: @application.machine_id, manager_id: @application.manager_id, name: @application.name, network: @application.network, network_id: @application.network_id, node_id: @application.node_id, notice: @application.notice, parent_process: @application.parent_process, priority: @application.priority, process_id: @application.process_id, pubserver_id: @application.pubserver_id, purpose: @application.purpose, server_id: @application.server_id, service: @application.service, status: @application.status, user_id: @application.user_id }
    assert_redirected_to application_path(assigns(:application))
  end

  test "should destroy application" do
    assert_difference('Application.count', -1) do
      delete :destroy, id: @application
    end

    assert_redirected_to applications_path
  end
end
