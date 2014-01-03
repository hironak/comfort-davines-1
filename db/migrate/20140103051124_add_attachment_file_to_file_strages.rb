class AddAttachmentFileToFileStrages < ActiveRecord::Migration
  def self.up
    change_table :file_strages do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :file_strages, :file
  end
end
