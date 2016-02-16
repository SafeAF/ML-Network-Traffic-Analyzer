json.array!(@gists) do |gist|
  json.extract! gist, :id, :owner, :user_id, :member_id, :name, :total_files, :description, :total_size, :github_id, :git_id, :project_id, :content
  json.url gist_url(gist, format: :json)
end
