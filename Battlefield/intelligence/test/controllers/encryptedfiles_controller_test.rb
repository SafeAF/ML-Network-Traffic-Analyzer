require 'test_helper'

class EncryptedfilesControllerTest < ActionController::TestCase
  setup do
    @encryptedfile = encryptedfiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:encryptedfiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create encryptedfile" do
    assert_difference('Encryptedfile.count') do
      post :create, encryptedfile: { name: @encryptedfile.name, path: @encryptedfile.path, privkey: @encryptedfile.privkey, pubkey: @encryptedfile.pubkey, server_id: @encryptedfile.server_id, user_id: @encryptedfile.user_id, vfilesystem_id: @encryptedfile.vfilesystem_id }
    end

    assert_redirected_to encryptedfile_path(assigns(:encryptedfile))
  end

  test "should show encryptedfile" do
    get :show, id: @encryptedfile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @encryptedfile
    assert_response :success
  end

  test "should update encryptedfile" do
    patch :update, id: @encryptedfile, encryptedfile: { name: @encryptedfile.name, path: @encryptedfile.path, privkey: @encryptedfile.privkey, pubkey: @encryptedfile.pubkey, server_id: @encryptedfile.server_id, user_id: @encryptedfile.user_id, vfilesystem_id: @encryptedfile.vfilesystem_id }
    assert_redirected_to encryptedfile_path(assigns(:encryptedfile))
  end

  test "should destroy encryptedfile" do
    assert_difference('Encryptedfile.count', -1) do
      delete :destroy, id: @encryptedfile
    end

    assert_redirected_to encryptedfiles_path
  end
end
