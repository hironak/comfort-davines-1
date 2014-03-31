class AddColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :postage, :integer
    add_column :orders, :commission, :integer
  end
end
