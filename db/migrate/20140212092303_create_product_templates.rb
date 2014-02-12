class CreateProductTemplates < ActiveRecord::Migration
  def change
    create_table :product_templates do |t|
      t.string :name
      t.text :header
      t.text :list
      t.text :style

      t.timestamps
    end
  end
end
