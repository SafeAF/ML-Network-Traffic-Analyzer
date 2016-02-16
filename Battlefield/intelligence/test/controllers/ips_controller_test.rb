require 'test_helper'

class IpsControllerTest < ActionController::TestCase
  setup do
    @ip = ips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ip" do
    assert_difference('Ip.count') do
      post :create, ip: { address: @ip.address, credibility_id: @ip.credibility_id, dns: @ip.dns, domainname_id: @ip.domainname_id, hostname: @ip.hostname, isp: @ip.isp, netblock: @ip.netblock, network_id: @ip.network_id, organization_id: @ip.organization_id, reputation: @ip.reputation, subnet: @ip.subnet }
    end

    assert_redirected_to ip_path(assigns(:ip))
  end

  test "should show ip" do
    get :show, id: @ip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ip
    assert_response :success
  end

  test "should update ip" do
    patch :update, id: @ip, ip: { address: @ip.address, credibility_id: @ip.credibility_id, dns: @ip.dns, domainname_id: @ip.domainname_id, hostname: @ip.hostname, isp: @ip.isp, netblock: @ip.netblock, network_id: @ip.network_id, organization_id: @ip.organization_id, reputation: @ip.reputation, subnet: @ip.subnet }
    assert_redirected_to ip_path(assigns(:ip))
  end

  test "should destroy ip" do
    assert_difference('Ip.count', -1) do
      delete :destroy, id: @ip
    end

    assert_redirected_to ips_path
  end
end
