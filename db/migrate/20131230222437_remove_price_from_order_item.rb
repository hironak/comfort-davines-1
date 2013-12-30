class RemovePriceFromOrderItem < ActiveRecord::Migration
  def change
    remove_column :order_items, :price, :integer
  end
end
