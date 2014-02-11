class AddSmallDetailToProduct < ActiveRecord::Migration
  def change
    add_column :products, :small_detail, :text
  end
end
