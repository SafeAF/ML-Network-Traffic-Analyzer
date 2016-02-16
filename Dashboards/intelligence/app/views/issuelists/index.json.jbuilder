json.array!(@issuelists) do |issuelist|
  json.extract! issuelist, :id, :name, :description, :project_id, :department_id
  json.url issuelist_url(issuelist, format: :json)
end
