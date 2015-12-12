json.array!(@tasklists) do |tasklist|
  json.extract! tasklist, :id, :name, :desc, :total_tasks, :project_id
  json.url tasklist_url(tasklist, format: :json)
end
