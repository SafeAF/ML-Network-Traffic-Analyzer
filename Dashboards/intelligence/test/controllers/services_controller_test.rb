require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  setup do
    @service = services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service" do
    assert_difference('Service.count') do
      post :create, service: { authority: @service.authority, cluster: @service.cluster, cluster_id: @service.cluster_id, configuration: @service.configuration, criticality: @service.criticality, description: @service.description, devops_id: @service.devops_id, distribution: @service.distribution, location: @service.location, machine_id: @service.machine_id, manager_id: @service.manager_id, name: @service.name, network_id: @service.network_id, pid: @service.pid, priority: @service.priority, purpose: @service.purpose, replication: @service.replication, server_id: @service.server_id, type: @service.type, user_id: @service.user_id, watchdog: @service.watchdog, webserver_id: @service.webserver_id }
    end

    assert_redirected_to service_path(assigns(:service))
  end

  test "should show service" do
    get :show, id: @service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service
    assert_response :success
  end

  test "should update service" do
    patch :update, id: @service, service: { authority: @service.authority, cluster: @service.cluster, cluster_id: @service.cluster_id, configuration: @service.configuration, criticality: @service.criticality, description: @service.description, devops_id: @service.devops_id, distribution: @service.distribution, location: @service.location, machine_id: @service.machine_id, manager_id: @service.manager_id, name: @service.name, network_id: @service.network_id, pid: @service.pid, priority: @service.priority, purpose: @service.purpose, replication: @service.replication, server_id: @service.server_id, type: @service.type, user_id: @service.user_id, watchdog: @service.watchdog, webserver_id: @service.webserver_id }
    assert_redirected_to service_path(assigns(:service))
  end

  test "should destroy service" do
    assert_difference('Service.count', -1) do
      delete :destroy, id: @service
    end

    assert_redirected_to services_path
  end
end
