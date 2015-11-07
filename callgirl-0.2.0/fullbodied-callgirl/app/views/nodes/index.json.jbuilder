json.array!(@nodes) do |node|
  json.extract! node, :id, :name, :ip, :hostname
  json.url node_url(node, format: :json)
end
