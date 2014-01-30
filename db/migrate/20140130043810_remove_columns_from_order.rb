class RemoveColumnsFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :payment, :string
    remove_column :orders, :address, :string
  end
end
