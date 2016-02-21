json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :details, :how, :who, :why, :pricing, :type, :releaseDate
  json.url product_url(product, format: :json)
end
