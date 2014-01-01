class AddAttachmentTopimageToSerieses < ActiveRecord::Migration
  def self.up
    change_table :series do |t|
      t.attachment :topimage
    end
  end

  def self.down
    drop_attached_file :series, :topimage
  end
end
