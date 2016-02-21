json.array!(@news) do |news|
  json.extract! news, :id, :name, :product, :description
  json.url news_url(news, format: :json)
end
