require 'test_helper'

class OpenportsControllerTest < ActionController::TestCase
  setup do
    @openport = openports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:openports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create openport" do
    assert_difference('Openport.count') do
      post :create, openport: { desc: @openport.desc, ip_id: @openport.ip_id, name: @openport.name, network_id: @openport.network_id, port: @openport.port, service_id: @openport.service_id }
    end

    assert_redirected_to openport_path(assigns(:openport))
  end

  test "should show openport" do
    get :show, id: @openport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @openport
    assert_response :success
  end

  test "should update openport" do
    patch :update, id: @openport, openport: { desc: @openport.desc, ip_id: @openport.ip_id, name: @openport.name, network_id: @openport.network_id, port: @openport.port, service_id: @openport.service_id }
    assert_redirected_to openport_path(assigns(:openport))
  end

  test "should destroy openport" do
    assert_difference('Openport.count', -1) do
      delete :destroy, id: @openport
    end

    assert_redirected_to openports_path
  end
end
