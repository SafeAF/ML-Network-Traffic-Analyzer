json.array!(@labels) do |label|
  json.extract! label, :id, :name, :label, :issue_id, :milestone_id
  json.url label_url(label, format: :json)
end
