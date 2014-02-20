class AddAmountToPaymentCollect < ActiveRecord::Migration
  def change
    add_column :payment_collects, :amount, :integer
  end
end
