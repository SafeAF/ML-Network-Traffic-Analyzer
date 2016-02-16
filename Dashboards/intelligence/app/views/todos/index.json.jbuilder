json.array!(@todos) do |todo|
  json.extract! todo, :id, :name, :desc, :eta, :project_id, :department_id, :infrastructure_id, :operations_id, :username_id, :team_id, :estimated_manhours, :total_manhours, :ratio_actual_manhours, :details, :tasklist_id, :user_id, :priority
  json.url todo_url(todo, format: :json)
end
