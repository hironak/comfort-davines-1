class AddShowOnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :show_on, :boolean
  end
end
