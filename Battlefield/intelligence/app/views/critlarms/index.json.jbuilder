json.array!(@critlarms) do |critlarm|
  json.extract! critlarm, :id, :name, :heading, :content, :body, :source, :destination, :pos_in_queque, :tied_to_ui_component, :populates_widget
  json.url critlarm_url(critlarm, format: :json)
end
