class FileStorageController < ApplicationController
  def show
    if file_storage = FileStorage.where(file_file_name: file_name).first
      send_data File.read(file_storage.file.path), type: file_storage.file.content_type
    elsif Rails.env.development?
      filename = File.join("#{Rails.root}/presets/**", file_name)
      if filename = Dir.glob(filename).first
        send_data File.read(filename), type: file_storage.file.content_type
      else
        render text: "not found #{filename}"
      end
      return
    end
  end

  private

  def file_name
    "#{params[:filename]}.#{params[:format]}"
  end
end
