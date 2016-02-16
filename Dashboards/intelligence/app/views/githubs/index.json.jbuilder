json.array!(@githubs) do |github|
  json.extract! github, :id, :owner, :member_id, :username, :password, :apikey, :user_id, :url, :membership_id
  json.url github_url(github, format: :json)
end
