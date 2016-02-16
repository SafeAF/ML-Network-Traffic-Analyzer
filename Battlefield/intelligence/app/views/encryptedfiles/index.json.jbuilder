json.array!(@encryptedfiles) do |encryptedfile|
  json.extract! encryptedfile, :id, :name, :user_id, :server_id, :path, :vfilesystem_id, :privkey, :pubkey
  json.url encryptedfile_url(encryptedfile, format: :json)
end
