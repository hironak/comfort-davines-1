class CreateProductsSeries < ActiveRecord::Migration
  def change
    create_table :products_serieses do |t|
      t.references :product, index: true
      t.references :series, index: true
    end
  end
end
