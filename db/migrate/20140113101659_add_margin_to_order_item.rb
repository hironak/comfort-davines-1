class AddMarginToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :backmargin_salon, :integer
    add_column :order_items, :backmargin_agency, :integer
  end
end
