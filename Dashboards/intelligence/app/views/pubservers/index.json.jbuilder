json.array!(@pubservers) do |pubserver|
  json.extract! pubserver, :id, :name, :ip, :hostname, :os, :dns, :whois, :organization, :organization_id, :reputation_id, :url, :applications, :application_id, :service_id, :app_version, :webserver, :webserver_id, :webserver_version
  json.url pubserver_url(pubserver, format: :json)
end
