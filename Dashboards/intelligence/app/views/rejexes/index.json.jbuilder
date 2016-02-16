json.array!(@rejexes) do |rejex|
  json.extract! rejex, :id, :name, :description, :body, :flag, :flag2, :flag3, :flag4, :flag5, :flag6, :pattern, :pattern2, :substitute, :return_field, :return_field1, :return_field2, :return_field3, :return_field4, :serialized
  json.url rejex_url(rejex, format: :json)
end
