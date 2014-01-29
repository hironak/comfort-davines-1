class AddOrderToShipment < ActiveRecord::Migration
  def change
    add_reference :shipments, :order, index: true
  end
end
