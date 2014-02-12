class FileStorageController < ApplicationController
  def show
    if Rails.env.development?
      filename = File.join("#{Rails.root}/presets/**", "#{params[:filename]}.*")
      if filename = Dir.glob(filename).first
        send_data File.read(filename)
      else
        render text: "not found #{filename}"
      end
      return
    end
    if file_storage = FileStorage.where(file_file_name: params[:filename]).first
      redirect_to file_storage.file.url
    end
  end
end
