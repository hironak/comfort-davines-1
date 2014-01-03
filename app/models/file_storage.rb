class FileStorage < ActiveRecord::Base
  has_attached_file :file
end
