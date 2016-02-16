require 'test_helper'

class WhoisesControllerTest < ActionController::TestCase
  setup do
    @whoise = whoises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:whoises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create whoise" do
    assert_difference('Whoise.count') do
      post :create, whoise: { content: @whoise.content, hostname: @whoise.hostname, ip: @whoise.ip, ip_id: @whoise.ip_id, last_crawled: @whoise.last_crawled, url_id: @whoise.url_id }
    end

    assert_redirected_to whoise_path(assigns(:whoise))
  end

  test "should show whoise" do
    get :show, id: @whoise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @whoise
    assert_response :success
  end

  test "should update whoise" do
    patch :update, id: @whoise, whoise: { content: @whoise.content, hostname: @whoise.hostname, ip: @whoise.ip, ip_id: @whoise.ip_id, last_crawled: @whoise.last_crawled, url_id: @whoise.url_id }
    assert_redirected_to whoise_path(assigns(:whoise))
  end

  test "should destroy whoise" do
    assert_difference('Whoise.count', -1) do
      delete :destroy, id: @whoise
    end

    assert_redirected_to whoises_path
  end
end
