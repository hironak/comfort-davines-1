class FileStorage < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  has_attached_file :file

  validates_attachment_content_type :file, :content_type => %w(image/jpeg image/jpg image/png image/gif)
end
