class AddCartIdToConsumer < ActiveRecord::Migration
  def change
    add_column :consumers, :cart_id, :integer
  end
end
