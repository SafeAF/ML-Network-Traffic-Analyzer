json.array!(@tables) do |table|
  json.extract! table, :id, :name, :rows, :row_headings, :content, :columns, :columns_count, :application_id, :database_id, :purpose, :criticality
  json.url table_url(table, format: :json)
end
