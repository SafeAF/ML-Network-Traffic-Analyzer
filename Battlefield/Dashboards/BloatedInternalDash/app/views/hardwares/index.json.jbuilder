json.array!(@hardwares) do |hardware|
  json.extract! hardware, :id, :name, :user_id, :machine_id, :inventory_id, :operations_id, :type, :purpose, :identifier, :size, :description, :details
  json.url hardware_url(hardware, format: :json)
end
