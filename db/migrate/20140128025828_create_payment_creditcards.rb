class CreatePaymentCreditcards < ActiveRecord::Migration
  def change
    create_table :payment_creditcards do |t|
      t.string :webpay_id

      t.timestamps
    end
  end
end
