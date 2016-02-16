json.array!(@domainnames) do |domainname|
  json.extract! domainname, :id, :ip_id, :cname, :aname, :mx, :mx2, :mx3, :mx4, :hostname, :reverse_lookup, :location, :isp, :organisation_id, :network_id, :server_id, :nameserver1, :nameserver2
  json.url domainname_url(domainname, format: :json)
end
