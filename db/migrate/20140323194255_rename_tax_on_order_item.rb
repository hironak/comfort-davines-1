class RenameTaxOnOrderItem < ActiveRecord::Migration
  def change
    rename_column :order_items, :tax, :tax_percentage
  end
end
