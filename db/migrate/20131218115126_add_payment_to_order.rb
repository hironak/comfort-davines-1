class AddPaymentToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payment, :text
  end
end
