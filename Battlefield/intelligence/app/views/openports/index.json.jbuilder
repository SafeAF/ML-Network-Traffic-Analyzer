json.array!(@openports) do |openport|
  json.extract! openport, :id, :name, :desc, :port, :ip_id, :service_id, :network_id
  json.url openport_url(openport, format: :json)
end
