require 'test_helper'

class LogfilesControllerTest < ActionController::TestCase
  setup do
    @logfile = logfiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logfiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logfile" do
    assert_difference('Logfile.count') do
      post :create, logfile: { basename: @logfile.basename, criticality: @logfile.criticality, description: @logfile.description, entries: @logfile.entries, entries_per_sec: @logfile.entries_per_sec, location: @logfile.location, machine_id: @logfile.machine_id, name: @logfile.name, path: @logfile.path, server_id: @logfile.server_id, service: @logfile.service, service_id: @logfile.service_id, size: @logfile.size }
    end

    assert_redirected_to logfile_path(assigns(:logfile))
  end

  test "should show logfile" do
    get :show, id: @logfile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logfile
    assert_response :success
  end

  test "should update logfile" do
    patch :update, id: @logfile, logfile: { basename: @logfile.basename, criticality: @logfile.criticality, description: @logfile.description, entries: @logfile.entries, entries_per_sec: @logfile.entries_per_sec, location: @logfile.location, machine_id: @logfile.machine_id, name: @logfile.name, path: @logfile.path, server_id: @logfile.server_id, service: @logfile.service, service_id: @logfile.service_id, size: @logfile.size }
    assert_redirected_to logfile_path(assigns(:logfile))
  end

  test "should destroy logfile" do
    assert_difference('Logfile.count', -1) do
      delete :destroy, id: @logfile
    end

    assert_redirected_to logfiles_path
  end
end
