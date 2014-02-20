class CreatePaymentDeferreds < ActiveRecord::Migration
  def change
    create_table :payment_deferreds do |t|

      t.timestamps
    end
  end
end
