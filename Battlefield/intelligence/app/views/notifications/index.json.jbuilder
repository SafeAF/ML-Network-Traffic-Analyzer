json.array!(@notifications) do |notification|
  json.extract! notification, :id, :machine_id, :user_id, :server_id, :message, :priority, :source, :destination, :cluster_id, :service_id, :application_id
  json.url notification_url(notification, format: :json)
end
