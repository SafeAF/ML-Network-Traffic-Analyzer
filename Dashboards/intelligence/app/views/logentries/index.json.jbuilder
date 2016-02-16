json.array!(@logentries) do |logentry|
  json.extract! logentry, :id, :logfile_id, :name, :message, :facility, :priority, :logged_at, :service, :service_id, :logentry_id
  json.url logentry_url(logentry, format: :json)
end
