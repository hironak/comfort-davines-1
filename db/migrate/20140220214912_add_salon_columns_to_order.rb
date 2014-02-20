class AddSalonColumnsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :salon_prefecture, :string
    add_column :orders, :salon_not_found, :boolean
  end
end
