class FileStorage < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  has_attached_file :file

  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  def self.load src
    if Rails.env.development? && File.exist?("#{Rails.root}/presets/assets/file_storage/images/#{src}")
      self.find_or_initialize_by(name: src).tap do |storage|
        storage.file = File.new("#{Rails.root}/presets/assets/file_storage/images/#{src}")
        storage.save
      end
    else
      self.where(name: src).first
    end
  end
end
