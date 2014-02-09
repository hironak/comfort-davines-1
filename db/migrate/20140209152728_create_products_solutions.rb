class CreateProductsSolutions < ActiveRecord::Migration
  def change
    create_table :products_solutions do |t|
      t.references :product, index: true
      t.references :solution, index: true
    end
  end
end
