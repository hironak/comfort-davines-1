class AddPartsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :parts, :string
  end
end
