require 'test_helper'

class RejexesControllerTest < ActionController::TestCase
  setup do
    @rejex = rejexes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rejexes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rejex" do
    assert_difference('Rejex.count') do
      post :create, rejex: { body: @rejex.body, description: @rejex.description, flag2: @rejex.flag2, flag3: @rejex.flag3, flag4: @rejex.flag4, flag5: @rejex.flag5, flag6: @rejex.flag6, flag: @rejex.flag, name: @rejex.name, pattern2: @rejex.pattern2, pattern: @rejex.pattern, return_field1: @rejex.return_field1, return_field2: @rejex.return_field2, return_field3: @rejex.return_field3, return_field4: @rejex.return_field4, return_field: @rejex.return_field, serialized: @rejex.serialized, substitute: @rejex.substitute }
    end

    assert_redirected_to rejex_path(assigns(:rejex))
  end

  test "should show rejex" do
    get :show, id: @rejex
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rejex
    assert_response :success
  end

  test "should update rejex" do
    patch :update, id: @rejex, rejex: { body: @rejex.body, description: @rejex.description, flag2: @rejex.flag2, flag3: @rejex.flag3, flag4: @rejex.flag4, flag5: @rejex.flag5, flag6: @rejex.flag6, flag: @rejex.flag, name: @rejex.name, pattern2: @rejex.pattern2, pattern: @rejex.pattern, return_field1: @rejex.return_field1, return_field2: @rejex.return_field2, return_field3: @rejex.return_field3, return_field4: @rejex.return_field4, return_field: @rejex.return_field, serialized: @rejex.serialized, substitute: @rejex.substitute }
    assert_redirected_to rejex_path(assigns(:rejex))
  end

  test "should destroy rejex" do
    assert_difference('Rejex.count', -1) do
      delete :destroy, id: @rejex
    end

    assert_redirected_to rejexes_path
  end
end
