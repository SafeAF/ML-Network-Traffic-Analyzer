require 'test_helper'

class SystemeventsControllerTest < ActionController::TestCase
  setup do
    @systemevent = systemevents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:systemevents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create systemevent" do
    assert_difference('Systemevent.count') do
      post :create, systemevent: { DeviceReportedTime: @systemevent.DeviceReportedTime, Facility: @systemevent.Facility, FromHost: @systemevent.FromHost, InfoUnitID: @systemevent.InfoUnitID, Message: @systemevent.Message, ReceivedAt: @systemevent.ReceivedAt, SysLogTag: @systemevent.SysLogTag }
    end

    assert_redirected_to systemevent_path(assigns(:systemevent))
  end

  test "should show systemevent" do
    get :show, id: @systemevent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @systemevent
    assert_response :success
  end

  test "should update systemevent" do
    patch :update, id: @systemevent, systemevent: { DeviceReportedTime: @systemevent.DeviceReportedTime, Facility: @systemevent.Facility, FromHost: @systemevent.FromHost, InfoUnitID: @systemevent.InfoUnitID, Message: @systemevent.Message, ReceivedAt: @systemevent.ReceivedAt, SysLogTag: @systemevent.SysLogTag }
    assert_redirected_to systemevent_path(assigns(:systemevent))
  end

  test "should destroy systemevent" do
    assert_difference('Systemevent.count', -1) do
      delete :destroy, id: @systemevent
    end

    assert_redirected_to systemevents_path
  end
end
