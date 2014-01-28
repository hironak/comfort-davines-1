class AddColumnsToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :payment, index: true
    add_column :orders, :payment_type, :string
  end
end
