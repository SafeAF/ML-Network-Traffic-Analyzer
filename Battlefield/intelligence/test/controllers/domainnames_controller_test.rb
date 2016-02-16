require 'test_helper'

class DomainnamesControllerTest < ActionController::TestCase
  setup do
    @domainname = domainnames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:domainnames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create domainname" do
    assert_difference('Domainname.count') do
      post :create, domainname: { aname: @domainname.aname, cname: @domainname.cname, hostname: @domainname.hostname, ip_id: @domainname.ip_id, isp: @domainname.isp, location: @domainname.location, mx2: @domainname.mx2, mx3: @domainname.mx3, mx4: @domainname.mx4, mx: @domainname.mx, nameserver1: @domainname.nameserver1, nameserver2: @domainname.nameserver2, network_id: @domainname.network_id, organisation_id: @domainname.organisation_id, reverse_lookup: @domainname.reverse_lookup, server_id: @domainname.server_id }
    end

    assert_redirected_to domainname_path(assigns(:domainname))
  end

  test "should show domainname" do
    get :show, id: @domainname
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @domainname
    assert_response :success
  end

  test "should update domainname" do
    patch :update, id: @domainname, domainname: { aname: @domainname.aname, cname: @domainname.cname, hostname: @domainname.hostname, ip_id: @domainname.ip_id, isp: @domainname.isp, location: @domainname.location, mx2: @domainname.mx2, mx3: @domainname.mx3, mx4: @domainname.mx4, mx: @domainname.mx, nameserver1: @domainname.nameserver1, nameserver2: @domainname.nameserver2, network_id: @domainname.network_id, organisation_id: @domainname.organisation_id, reverse_lookup: @domainname.reverse_lookup, server_id: @domainname.server_id }
    assert_redirected_to domainname_path(assigns(:domainname))
  end

  test "should destroy domainname" do
    assert_difference('Domainname.count', -1) do
      delete :destroy, id: @domainname
    end

    assert_redirected_to domainnames_path
  end
end
