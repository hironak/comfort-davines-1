class CreateFileStorages < ActiveRecord::Migration
  def change
    create_table :file_storages do |t|
      t.string :name
      t.string :path

      t.timestamps
    end
  end
end
