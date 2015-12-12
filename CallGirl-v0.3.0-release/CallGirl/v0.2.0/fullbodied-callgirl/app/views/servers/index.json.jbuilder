json.array!(@servers) do |server|
  json.extract! server, :id, :name, :username, :password, :privkey, :pubkey, :key, :ip, :hostname, :cluster, :ipaddr, :string, :machine_id, :cluster_id, :virtual?, :up?, :criticality, :priority, :network_id, :manager_id, :os, :devops_id, :uptime, :system_id, :user_id, :configuration
  json.url server_url(server, format: :json)
end
