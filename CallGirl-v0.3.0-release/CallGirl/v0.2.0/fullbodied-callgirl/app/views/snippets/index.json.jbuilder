json.array!(@snippets) do |snippet|
  json.extract! snippet, :id, :name, :description, :code, :authored_at
  json.url snippet_url(snippet, format: :json)
end
