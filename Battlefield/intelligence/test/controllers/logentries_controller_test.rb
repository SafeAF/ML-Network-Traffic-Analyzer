require 'test_helper'

class LogentriesControllerTest < ActionController::TestCase
  setup do
    @logentry = logentries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logentries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logentry" do
    assert_difference('Logentry.count') do
      post :create, logentry: { facility: @logentry.facility, logentry_id: @logentry.logentry_id, logfile_id: @logentry.logfile_id, logged_at: @logentry.logged_at, message: @logentry.message, name: @logentry.name, priority: @logentry.priority, service: @logentry.service, service_id: @logentry.service_id }
    end

    assert_redirected_to logentry_path(assigns(:logentry))
  end

  test "should show logentry" do
    get :show, id: @logentry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logentry
    assert_response :success
  end

  test "should update logentry" do
    patch :update, id: @logentry, logentry: { facility: @logentry.facility, logentry_id: @logentry.logentry_id, logfile_id: @logentry.logfile_id, logged_at: @logentry.logged_at, message: @logentry.message, name: @logentry.name, priority: @logentry.priority, service: @logentry.service, service_id: @logentry.service_id }
    assert_redirected_to logentry_path(assigns(:logentry))
  end

  test "should destroy logentry" do
    assert_difference('Logentry.count', -1) do
      delete :destroy, id: @logentry
    end

    assert_redirected_to logentries_path
  end
end
