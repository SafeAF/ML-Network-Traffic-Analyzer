json.array!(@systemevents) do |systemevent|
  json.extract! systemevent, :id, :Message, :Facility, :FromHost, :DeviceReportedTime, :ReceivedAt, :InfoUnitID, :SysLogTag
  json.url systemevent_url(systemevent, format: :json)
end
