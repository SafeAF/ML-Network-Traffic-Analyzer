require 'test_helper'

class NetworksControllerTest < ActionController::TestCase
  setup do
    @network = networks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:networks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create network" do
    assert_difference('Network.count') do
      post :create, network: { a_record: @network.a_record, address_space: @network.address_space, average_latency: @network.average_latency, broadcast: @network.broadcast, cluster_id: @network.cluster_id, dns: @network.dns, gateway_ip: @network.gateway_ip, health: @network.health, hops: @network.hops, infrastructure_id: @network.infrastructure_id, lan_ip: @network.lan_ip, latency: @network.latency, name: @network.name, netadmin: @network.netadmin, netmask: @network.netmask, network: @network.network, network_box: @network.network_box, nodes_alive: @network.nodes_alive, operations_id: @network.operations_id, ownership: @network.ownership, ping: @network.ping, ptr_record: @network.ptr_record, purpose: @network.purpose, reverse_address: @network.reverse_address, router_ip: @network.router_ip, speed: @network.speed, subnet: @network.subnet, total_nodes: @network.total_nodes, type: @network.type, user_id: @network.user_id, usernames_id: @network.usernames_id, wan_ip: @network.wan_ip, wifi_ssid: @network.wifi_ssid }
    end

    assert_redirected_to network_path(assigns(:network))
  end

  test "should show network" do
    get :show, id: @network
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @network
    assert_response :success
  end

  test "should update network" do
    patch :update, id: @network, network: { a_record: @network.a_record, address_space: @network.address_space, average_latency: @network.average_latency, broadcast: @network.broadcast, cluster_id: @network.cluster_id, dns: @network.dns, gateway_ip: @network.gateway_ip, health: @network.health, hops: @network.hops, infrastructure_id: @network.infrastructure_id, lan_ip: @network.lan_ip, latency: @network.latency, name: @network.name, netadmin: @network.netadmin, netmask: @network.netmask, network: @network.network, network_box: @network.network_box, nodes_alive: @network.nodes_alive, operations_id: @network.operations_id, ownership: @network.ownership, ping: @network.ping, ptr_record: @network.ptr_record, purpose: @network.purpose, reverse_address: @network.reverse_address, router_ip: @network.router_ip, speed: @network.speed, subnet: @network.subnet, total_nodes: @network.total_nodes, type: @network.type, user_id: @network.user_id, usernames_id: @network.usernames_id, wan_ip: @network.wan_ip, wifi_ssid: @network.wifi_ssid }
    assert_redirected_to network_path(assigns(:network))
  end

  test "should destroy network" do
    assert_difference('Network.count', -1) do
      delete :destroy, id: @network
    end

    assert_redirected_to networks_path
  end
end
