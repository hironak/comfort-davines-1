class AddTaxToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :tax, :integer, default: 5
  end
end
