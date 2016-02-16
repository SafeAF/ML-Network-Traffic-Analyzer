json.array!(@services) do |service|
  json.extract! service, :id, :name, :description, :type, :location, :server_id, :webserver_id, :machine_id, :cluster_id, :user_id, :distribution, :cluster, :replication, :authority, :purpose, :watchdog, :pid, :criticality, :priority, :network_id, :manager_id, :devops_id, :configuration
  json.url service_url(service, format: :json)
end
