json.array!(@logfiles) do |logfile|
  json.extract! logfile, :id, :machine_id, :name, :description, :size, :entries, :entries_per_sec, :location, :path, :basename, :service, :service_id, :server_id, :criticality
  json.url logfile_url(logfile, format: :json)
end
