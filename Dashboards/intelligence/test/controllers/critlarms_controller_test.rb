require 'test_helper'

class CritlarmsControllerTest < ActionController::TestCase
  setup do
    @critlarm = critlarms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:critlarms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create critlarm" do
    assert_difference('Critlarm.count') do
      post :create, critlarm: { body: @critlarm.body, content: @critlarm.content, destination: @critlarm.destination, heading: @critlarm.heading, name: @critlarm.name, populates_widget: @critlarm.populates_widget, pos_in_queque: @critlarm.pos_in_queque, source: @critlarm.source, tied_to_ui_component: @critlarm.tied_to_ui_component }
    end

    assert_redirected_to critlarm_path(assigns(:critlarm))
  end

  test "should show critlarm" do
    get :show, id: @critlarm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @critlarm
    assert_response :success
  end

  test "should update critlarm" do
    patch :update, id: @critlarm, critlarm: { body: @critlarm.body, content: @critlarm.content, destination: @critlarm.destination, heading: @critlarm.heading, name: @critlarm.name, populates_widget: @critlarm.populates_widget, pos_in_queque: @critlarm.pos_in_queque, source: @critlarm.source, tied_to_ui_component: @critlarm.tied_to_ui_component }
    assert_redirected_to critlarm_path(assigns(:critlarm))
  end

  test "should destroy critlarm" do
    assert_difference('Critlarm.count', -1) do
      delete :destroy, id: @critlarm
    end

    assert_redirected_to critlarms_path
  end
end
