json.array!(@issues) do |issue|
  json.extract! issue, :id, :name, :author, :assignee, :project_id, :description, :content, :department_id, :infrastructure_id, :operations_id, :username_id, :user_id, :labels, :label_id
  json.url issue_url(issue, format: :json)
end
