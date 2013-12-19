class AddCartIdToCart < ActiveRecord::Migration
  def change
    add_column :carts, :consumer_id, :integer
  end
end
