json.array!(@torrents) do |torrent|
  json.extract! torrent, :id, :name, :url, :tracker, :torrentfile, :torrent, :location, :server_id, :application_id, :torrentsite
  json.url torrent_url(torrent, format: :json)
end
