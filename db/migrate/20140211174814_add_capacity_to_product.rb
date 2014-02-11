class AddCapacityToProduct < ActiveRecord::Migration
  def change
    add_column :products, :capacity, :string
  end
end
