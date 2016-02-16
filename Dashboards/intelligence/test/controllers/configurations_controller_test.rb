require 'test_helper'

class ConfigurationsControllerTest < ActionController::TestCase
  setup do
    @configuration = configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create configuration" do
    assert_difference('Configuration.count') do
      post :create, configuration: { alt_config: @configuration.alt_config, application_id: @configuration.application_id, config: @configuration.config, description: @configuration.description, fvar2: @configuration.fvar2, fvar: @configuration.fvar, ivar2: @configuration.ivar2, ivar3: @configuration.ivar3, ivar: @configuration.ivar, machine_id: @configuration.machine_id, name: @configuration.name, purpose: @configuration.purpose, server_id: @configuration.server_id, service_id: @configuration.service_id, var2: @configuration.var2, var3: @configuration.var3, var4: @configuration.var4, var5: @configuration.var5, var: @configuration.var, version: @configuration.version }
    end

    assert_redirected_to configuration_path(assigns(:configuration))
  end

  test "should show configuration" do
    get :show, id: @configuration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @configuration
    assert_response :success
  end

  test "should update configuration" do
    patch :update, id: @configuration, configuration: { alt_config: @configuration.alt_config, application_id: @configuration.application_id, config: @configuration.config, description: @configuration.description, fvar2: @configuration.fvar2, fvar: @configuration.fvar, ivar2: @configuration.ivar2, ivar3: @configuration.ivar3, ivar: @configuration.ivar, machine_id: @configuration.machine_id, name: @configuration.name, purpose: @configuration.purpose, server_id: @configuration.server_id, service_id: @configuration.service_id, var2: @configuration.var2, var3: @configuration.var3, var4: @configuration.var4, var5: @configuration.var5, var: @configuration.var, version: @configuration.version }
    assert_redirected_to configuration_path(assigns(:configuration))
  end

  test "should destroy configuration" do
    assert_difference('Configuration.count', -1) do
      delete :destroy, id: @configuration
    end

    assert_redirected_to configurations_path
  end
end
