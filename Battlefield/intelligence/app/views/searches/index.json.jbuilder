json.array!(@searches) do |search|
  json.extract! search, :id, :field, :field2, :field3, :field4, :field5, :field6, :field7
  json.url search_url(search, format: :json)
end
