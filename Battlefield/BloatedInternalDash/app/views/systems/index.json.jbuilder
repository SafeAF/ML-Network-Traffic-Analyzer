json.array!(@systems) do |system|
  json.extract! system, :id, :name, :cluster_id, :infrastructure_id, :criticality, :description, :version, :body
  json.url system_url(system, format: :json)
end
