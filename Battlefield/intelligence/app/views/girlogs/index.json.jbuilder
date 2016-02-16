json.array!(@girlogs) do |girlog|
  json.extract! girlog, :id, :name, :desc, :context, :component, :originator, :body, :generated_at, :application, :facility, :priority, :criticality, :error, :error_count, :response_time, :latency, :db_latency, :query_time, :query, :rows_count, :response_code, :http_code, :client, :user, :hostname, :pid, :program
  json.url girlog_url(girlog, format: :json)
end
