require 'test_helper'

class DatabasesControllerTest < ActionController::TestCase
  setup do
    @database = databases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:databases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create database" do
    assert_difference('Database.count') do
      post :create, database: { application_id: @database.application_id, cluster: @database.cluster, cluster_id: @database.cluster_id, connection_string: @database.connection_string, count: @database.count, criticality: @database.criticality, db: @database.db, dbserver: @database.dbserver, devops_id: @database.devops_id, hostname: @database.hostname, infrastructure_id: @database.infrastructure_id, machine_id: @database.machine_id, name: @database.name, network_id: @database.network_id, password: @database.password, priority: @database.priority, purpose: @database.purpose, server_id: @database.server_id, service_id: @database.service_id, status: @database.status, type: @database.type, user: @database.user }
    end

    assert_redirected_to database_path(assigns(:database))
  end

  test "should show database" do
    get :show, id: @database
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @database
    assert_response :success
  end

  test "should update database" do
    patch :update, id: @database, database: { application_id: @database.application_id, cluster: @database.cluster, cluster_id: @database.cluster_id, connection_string: @database.connection_string, count: @database.count, criticality: @database.criticality, db: @database.db, dbserver: @database.dbserver, devops_id: @database.devops_id, hostname: @database.hostname, infrastructure_id: @database.infrastructure_id, machine_id: @database.machine_id, name: @database.name, network_id: @database.network_id, password: @database.password, priority: @database.priority, purpose: @database.purpose, server_id: @database.server_id, service_id: @database.service_id, status: @database.status, type: @database.type, user: @database.user }
    assert_redirected_to database_path(assigns(:database))
  end

  test "should destroy database" do
    assert_difference('Database.count', -1) do
      delete :destroy, id: @database
    end

    assert_redirected_to databases_path
  end
end
