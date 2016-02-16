json.array!(@pids) do |pid|
  json.extract! pid, :id, :name, :pid, :process, :filehandles, :filehandle, :path, :proctime, :walltime, :io, :netio, :iowait, :memory, :machine_id, :server_id, :node_id, :network_id, :manager_id, :application_id, :service_id
  json.url pid_url(pid, format: :json)
end
