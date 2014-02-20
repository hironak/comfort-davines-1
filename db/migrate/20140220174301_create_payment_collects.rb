class CreatePaymentCollects < ActiveRecord::Migration
  def change
    create_table :payment_collects do |t|

      t.timestamps
    end
  end
end
