class CreateAdministrationPages < ActiveRecord::Migration
  def change
    create_table :administration_pages do |t|
      t.text :body
      t.text :style

      t.timestamps
    end
  end
end
