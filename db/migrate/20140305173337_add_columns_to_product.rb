class AddColumnsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :new_item, :boolean
    add_column :products, :ranking, :integer
  end
end
