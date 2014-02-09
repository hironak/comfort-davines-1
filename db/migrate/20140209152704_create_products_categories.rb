class CreateProductsCategories < ActiveRecord::Migration
  def change
    create_table :products_categories, id: false do |t|
      t.references :product, index: true
      t.references :category, index: true
    end
  end
end
