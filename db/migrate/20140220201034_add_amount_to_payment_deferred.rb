class AddAmountToPaymentDeferred < ActiveRecord::Migration
  def change
    add_column :payment_deferreds, :amount, :integer
  end
end
