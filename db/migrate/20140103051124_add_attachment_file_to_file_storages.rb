class AddAttachmentFileToFileStorages < ActiveRecord::Migration
  def self.up
    change_table :file_storages do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :file_storages, :file
  end
end
