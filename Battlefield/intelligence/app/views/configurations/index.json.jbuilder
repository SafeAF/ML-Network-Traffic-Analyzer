json.array!(@configurations) do |configuration|
  json.extract! configuration, :id, :name, :purpose, :description, :machine_id, :server_id, :application_id, :service_id, :config, :alt_config, :version, :var, :var2, :var3, :var4, :var5, :ivar, :ivar2, :ivar3, :fvar, :fvar2
  json.url configuration_url(configuration, format: :json)
end
