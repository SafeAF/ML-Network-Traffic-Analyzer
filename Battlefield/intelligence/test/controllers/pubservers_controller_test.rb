require 'test_helper'

class PubserversControllerTest < ActionController::TestCase
  setup do
    @pubserver = pubservers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pubservers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pubserver" do
    assert_difference('Pubserver.count') do
      post :create, pubserver: { app_version: @pubserver.app_version, application_id: @pubserver.application_id, applications: @pubserver.applications, dns: @pubserver.dns, hostname: @pubserver.hostname, ip: @pubserver.ip, name: @pubserver.name, organization: @pubserver.organization, organization_id: @pubserver.organization_id, os: @pubserver.os, reputation_id: @pubserver.reputation_id, service_id: @pubserver.service_id, url: @pubserver.url, webserver: @pubserver.webserver, webserver_id: @pubserver.webserver_id, webserver_version: @pubserver.webserver_version, whois: @pubserver.whois }
    end

    assert_redirected_to pubserver_path(assigns(:pubserver))
  end

  test "should show pubserver" do
    get :show, id: @pubserver
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pubserver
    assert_response :success
  end

  test "should update pubserver" do
    patch :update, id: @pubserver, pubserver: { app_version: @pubserver.app_version, application_id: @pubserver.application_id, applications: @pubserver.applications, dns: @pubserver.dns, hostname: @pubserver.hostname, ip: @pubserver.ip, name: @pubserver.name, organization: @pubserver.organization, organization_id: @pubserver.organization_id, os: @pubserver.os, reputation_id: @pubserver.reputation_id, service_id: @pubserver.service_id, url: @pubserver.url, webserver: @pubserver.webserver, webserver_id: @pubserver.webserver_id, webserver_version: @pubserver.webserver_version, whois: @pubserver.whois }
    assert_redirected_to pubserver_path(assigns(:pubserver))
  end

  test "should destroy pubserver" do
    assert_difference('Pubserver.count', -1) do
      delete :destroy, id: @pubserver
    end

    assert_redirected_to pubservers_path
  end
end
