class AddAmountToPaymentCreditcard < ActiveRecord::Migration
  def change
    add_column :payment_creditcards, :amount, :integer
  end
end
