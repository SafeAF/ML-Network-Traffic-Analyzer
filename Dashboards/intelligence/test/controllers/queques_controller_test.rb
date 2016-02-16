require 'test_helper'

class QuequesControllerTest < ActionController::TestCase
  setup do
    @queque = queques(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:queques)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create queque" do
    assert_difference('Queque.count') do
      post :create, queque: { critlarm_id: @queque.critlarm_id, name: @queque.name }
    end

    assert_redirected_to queque_path(assigns(:queque))
  end

  test "should show queque" do
    get :show, id: @queque
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @queque
    assert_response :success
  end

  test "should update queque" do
    patch :update, id: @queque, queque: { critlarm_id: @queque.critlarm_id, name: @queque.name }
    assert_redirected_to queque_path(assigns(:queque))
  end

  test "should destroy queque" do
    assert_difference('Queque.count', -1) do
      delete :destroy, id: @queque
    end

    assert_redirected_to queques_path
  end
end
