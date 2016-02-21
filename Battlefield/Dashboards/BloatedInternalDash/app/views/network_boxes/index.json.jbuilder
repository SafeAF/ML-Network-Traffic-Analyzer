json.array!(@network_boxes) do |network_box|
  json.extract! network_box, :id, :name, :hostname, :ip, :type, :manufacturer, :model, :router, :gateway, :network_id, :infrastructure_id, :gateway_ip, :os, :operations_id, :configuration
  json.url network_box_url(network_box, format: :json)
end
