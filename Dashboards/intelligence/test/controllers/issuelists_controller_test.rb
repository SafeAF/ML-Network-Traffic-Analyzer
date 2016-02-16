require 'test_helper'

class IssuelistsControllerTest < ActionController::TestCase
  setup do
    @issuelist = issuelists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:issuelists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create issuelist" do
    assert_difference('Issuelist.count') do
      post :create, issuelist: { department_id: @issuelist.department_id, description: @issuelist.description, name: @issuelist.name, project_id: @issuelist.project_id }
    end

    assert_redirected_to issuelist_path(assigns(:issuelist))
  end

  test "should show issuelist" do
    get :show, id: @issuelist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @issuelist
    assert_response :success
  end

  test "should update issuelist" do
    patch :update, id: @issuelist, issuelist: { department_id: @issuelist.department_id, description: @issuelist.description, name: @issuelist.name, project_id: @issuelist.project_id }
    assert_redirected_to issuelist_path(assigns(:issuelist))
  end

  test "should destroy issuelist" do
    assert_difference('Issuelist.count', -1) do
      delete :destroy, id: @issuelist
    end

    assert_redirected_to issuelists_path
  end
end
