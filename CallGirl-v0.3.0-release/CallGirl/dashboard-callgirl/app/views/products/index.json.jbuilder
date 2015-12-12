json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :details, :price, :url, :type, :inventory
  json.url product_url(product, format: :json)
end
