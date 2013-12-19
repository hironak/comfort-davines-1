class RemoveCartIdFromConsumer < ActiveRecord::Migration
  def change
    remove_column :consumers, :cart_id, :integer
  end
end
