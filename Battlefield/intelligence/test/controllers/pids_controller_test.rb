require 'test_helper'

class PidsControllerTest < ActionController::TestCase
  setup do
    @pid = pids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pid" do
    assert_difference('Pid.count') do
      post :create, pid: { application_id: @pid.application_id, filehandle: @pid.filehandle, filehandles: @pid.filehandles, io: @pid.io, iowait: @pid.iowait, machine_id: @pid.machine_id, manager_id: @pid.manager_id, memory: @pid.memory, name: @pid.name, netio: @pid.netio, network_id: @pid.network_id, node_id: @pid.node_id, path: @pid.path, pid: @pid.pid, process: @pid.process, proctime: @pid.proctime, server_id: @pid.server_id, service_id: @pid.service_id, walltime: @pid.walltime }
    end

    assert_redirected_to pid_path(assigns(:pid))
  end

  test "should show pid" do
    get :show, id: @pid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pid
    assert_response :success
  end

  test "should update pid" do
    patch :update, id: @pid, pid: { application_id: @pid.application_id, filehandle: @pid.filehandle, filehandles: @pid.filehandles, io: @pid.io, iowait: @pid.iowait, machine_id: @pid.machine_id, manager_id: @pid.manager_id, memory: @pid.memory, name: @pid.name, netio: @pid.netio, network_id: @pid.network_id, node_id: @pid.node_id, path: @pid.path, pid: @pid.pid, process: @pid.process, proctime: @pid.proctime, server_id: @pid.server_id, service_id: @pid.service_id, walltime: @pid.walltime }
    assert_redirected_to pid_path(assigns(:pid))
  end

  test "should destroy pid" do
    assert_difference('Pid.count', -1) do
      delete :destroy, id: @pid
    end

    assert_redirected_to pids_path
  end
end
