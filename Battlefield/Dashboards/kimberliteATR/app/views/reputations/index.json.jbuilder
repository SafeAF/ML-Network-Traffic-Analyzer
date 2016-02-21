json.array!(@reputations) do |reputation|
  json.extract! reputation, :id, :ip_id, :domain_id, :confidence, :description, :value
  json.url reputation_url(reputation, format: :json)
end
