json.array!(@issues) do |issue|
  json.extract! issue, :id, :name, :author, :assignee, :user_id, :labels, :label_id
  json.url issue_url(issue, format: :json)
end
