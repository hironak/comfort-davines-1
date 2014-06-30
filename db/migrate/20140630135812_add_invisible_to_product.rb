class AddInvisibleToProduct < ActiveRecord::Migration
  def change
    add_column :products, :invisible, :boolean, default: false
  end
end
