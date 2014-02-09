class AddProductToProductPhoto < ActiveRecord::Migration
  def change
    add_reference :product_photos, :product, index: true
  end
end
