json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name, :address, :phone, :employees, :details, :description, :criticality
  json.url organization_url(organization, format: :json)
end
