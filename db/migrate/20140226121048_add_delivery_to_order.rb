class AddDeliveryToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_date, :string, default: ''
    add_column :orders, :delivery_time, :string, default: ''
  end
end
