class AddSmartDetailToProduct < ActiveRecord::Migration
  def change
    add_column :products, :smart_detail, :text
  end
end
