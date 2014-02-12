class FileStorageController < ApplicationController
  def show
    if file_storage = FileStorage.where(file_file_name: file_name).first
      redirect_to file_storage.file.url
    elsif Rails.env.development?
      filename = File.join("#{Rails.root}/presets/**", file_name)
      if filename = Dir.glob(filename).first
        send_data File.read(filename)
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
