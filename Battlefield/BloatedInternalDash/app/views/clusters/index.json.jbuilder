json.array!(@clusters) do |cluster|
  json.extract! cluster, :id, :user_id, :infrastructure_id, :name, :cluster_type, :members, :resource_manager, :information, :status, :details, :organization_id
  json.url cluster_url(cluster, format: :json)
end
