module FileStorageHelper
  def storage_image_tag src, *options
    if file_storage = FileStorage.where(file_file_name: src).first
      image_tag file_storage.file.url, *options
    else
      image_tag ''
    end
  end
end
