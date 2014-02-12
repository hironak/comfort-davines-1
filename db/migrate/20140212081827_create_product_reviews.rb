class CreateProductReviews < ActiveRecord::Migration
  def change
    create_table :product_reviews do |t|
      t.references :product, index: true
      t.text :body

      t.timestamps
    end
  end
end
