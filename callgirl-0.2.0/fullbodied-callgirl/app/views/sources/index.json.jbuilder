json.array!(@sources) do |source|
  json.extract! source, :id, :name, :body, :description, :user_id, :developer_id
  json.url source_url(source, format: :json)
end
