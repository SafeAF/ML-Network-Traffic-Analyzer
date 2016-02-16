json.array!(@memberships) do |membership|
  json.extract! membership, :id, :name, :url, :user_id, :member_id, :password, :username
  json.url membership_url(membership, format: :json)
end
