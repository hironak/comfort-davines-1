class AddIngredientToProduct < ActiveRecord::Migration
  def change
    add_column :products, :ingredient, :text
  end
end
