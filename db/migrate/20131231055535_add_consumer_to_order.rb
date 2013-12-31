class AddConsumerToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :consumer, index: true
  end
end
