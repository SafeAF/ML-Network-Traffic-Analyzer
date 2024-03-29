json.array!(@networks) do |network|
  json.extract! network, :id, :name, :purpose, :type, :speed, :infrastructure_id, :ownership, :netadmin, :user_id, :cluster_id, :gateway_ip, :ping, :hops, :latency, :router_ip, :broadcast, :address_space, :dns, :ptr_record, :a_record, :reverse_address, :network_box, :operations_id, :wifi_ssid, :wan_ip, :lan_ip
  json.url network_url(network, format: :json)
end
