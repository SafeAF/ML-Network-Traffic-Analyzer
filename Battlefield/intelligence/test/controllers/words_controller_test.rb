require 'test_helper'

class WordsControllerTest < ActionController::TestCase
  setup do
    @word = words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create word" do
    assert_difference('Word.count') do
      post :create, word: { current_sign_in_at: @word.current_sign_in_at, current_sign_in_ip: @word.current_sign_in_ip, email: @word.email, encrypted_password: @word.encrypted_password, last_sign_in_at: @word.last_sign_in_at, last_sign_in_ip: @word.last_sign_in_ip, name: @word.name, remember_created_at: @word.remember_created_at, reset_password_sent_at: @word.reset_password_sent_at, reset_password_token: @word.reset_password_token, role: @word.role, sign_in_count: @word.sign_in_count, stem: @word.stem }
    end

    assert_redirected_to word_path(assigns(:word))
  end

  test "should show word" do
    get :show, id: @word
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @word
    assert_response :success
  end

  test "should update word" do
    patch :update, id: @word, word: { current_sign_in_at: @word.current_sign_in_at, current_sign_in_ip: @word.current_sign_in_ip, email: @word.email, encrypted_password: @word.encrypted_password, last_sign_in_at: @word.last_sign_in_at, last_sign_in_ip: @word.last_sign_in_ip, name: @word.name, remember_created_at: @word.remember_created_at, reset_password_sent_at: @word.reset_password_sent_at, reset_password_token: @word.reset_password_token, role: @word.role, sign_in_count: @word.sign_in_count, stem: @word.stem }
    assert_redirected_to word_path(assigns(:word))
  end

  test "should destroy word" do
    assert_difference('Word.count', -1) do
      delete :destroy, id: @word
    end

    assert_redirected_to words_path
  end
end
