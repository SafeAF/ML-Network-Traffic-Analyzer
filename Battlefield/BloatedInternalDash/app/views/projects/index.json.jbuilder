json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :details, :infrastructure_id, :research_id, :developer_id, :application_id, :projected_completion, :username_id, :user_id, :member_id, :manhours, :eta, :completion_percentage
  json.url project_url(project, format: :json)
end
