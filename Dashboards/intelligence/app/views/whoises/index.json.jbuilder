json.array!(@whoises) do |whoise|
  json.extract! whoise, :id, :url_id, :hostname, :ip, :ip_id, :content, :last_crawled
  json.url whoise_url(whoise, format: :json)
end
