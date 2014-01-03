json.array!(@file_storages) do |file_storage|
  json.extract! file_storage, :id, :name, :path, :file
  json.url admin_file_storage_url(file_storage, format: :json)
end
