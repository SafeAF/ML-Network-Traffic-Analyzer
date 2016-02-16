json.array!(@ips) do |ip|
  json.extract! ip, :id, :address, :hostname, :dns, :isp, :netblock, :subnet, :network_id, :reputation, :domainname_id, :organization_id, :credibility_id
  json.url ip_url(ip, format: :json)
end
