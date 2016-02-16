json.array!(@departments) do |department|
  json.extract! department, :id, :string, :string, :integer, :text
  json.url department_url(department, format: :json)
end
