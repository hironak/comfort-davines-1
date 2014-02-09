class CreateCategoryItems < ActiveRecord::Migration
  def change
    create_table :category_items do |t|
      t.string :name
      t.references :category, index: true

      t.timestamps
    end
  end
end
