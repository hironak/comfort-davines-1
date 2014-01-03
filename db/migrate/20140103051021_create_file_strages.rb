class CreateFileStrages < ActiveRecord::Migration
  def change
    create_table :file_strages do |t|
      t.string :name
      t.string :path

      t.timestamps
    end
  end
end
