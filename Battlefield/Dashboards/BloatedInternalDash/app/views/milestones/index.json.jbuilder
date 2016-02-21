json.array!(@milestones) do |milestone|
  json.extract! milestone, :id, :name, :heading, :body, :duedate, :complete, :open, :closed
  json.url milestone_url(milestone, format: :json)
end
