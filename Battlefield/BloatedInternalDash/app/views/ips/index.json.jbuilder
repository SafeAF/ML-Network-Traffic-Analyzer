json.array!(@ips) do |ip|
  json.extract! ip, :id, :address, :hostname, :dns, :isp, :netblock, :subnet, :network_id, :reputation, :dns_id, :organization_id
  json.url ip_url(ip, format: :json)
end
