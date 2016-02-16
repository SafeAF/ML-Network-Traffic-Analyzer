json.array!(@todos) do |todo|
  json.extract! todo, :id, :name, :desc, :eta, :estimated_manhours, :total_manhours, :ratio_actual_manhours, :details, :tasklist_id, :user_id, :priority
  json.url todo_url(todo, format: :json)
end
