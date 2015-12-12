json.array!(@clusterbots) do |clusterbot|
  json.extract! clusterbot, :id, :name, :hostname, :ip, :cluster_id, :uptime, :configuration
  json.url clusterbot_url(clusterbot, format: :json)
end
