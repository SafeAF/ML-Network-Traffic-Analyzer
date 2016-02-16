json.array!(@groups) do |group|
  json.extract! group, :id, :name, :vfilesystem_id, :user, :machine_id, :server_id, :purpose, :incept_date, :access_level
  json.url group_url(group, format: :json)
end
