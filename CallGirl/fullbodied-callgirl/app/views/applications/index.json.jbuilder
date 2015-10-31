json.array!(@applications) do |application|
  json.extract! application, :id, :name, :purpose, :description, :hostname, :parent_process, :process_id, :service, :notice, :node_id, :criticality, :priority, :machine_id, :server_id, :user_id, :network, :network_id, :manager_id, :status, :developer_id, :pubserver_id
  json.url application_url(application, format: :json)
end
