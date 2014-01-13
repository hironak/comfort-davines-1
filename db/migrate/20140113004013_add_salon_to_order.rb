class AddSalonToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :salon_name, :string
    add_reference :orders, :salon, index: true
  end
end
