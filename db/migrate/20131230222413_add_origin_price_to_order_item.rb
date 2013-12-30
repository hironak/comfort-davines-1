class AddOriginPriceToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :origin_price, :integer
  end
end
