json.array!(@queques) do |queque|
  json.extract! queque, :id, :name, :critlarm_id
  json.url queque_url(queque, format: :json)
end
