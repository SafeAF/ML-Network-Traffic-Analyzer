json.array!(@databases) do |database|
  json.extract! database, :id, :name, :hostname, :cluster, :type, :dbserver, :db, :count, :user, :password, :connection_string, :server_id, :machine_id, :cluster_id, :service_id, :application_id, :infrastructure_id, :status, :purpose, :criticality, :priority, :network_id, :devops_id
  json.url database_url(database, format: :json)
end
