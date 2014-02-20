class RenameColumnOnShipment < ActiveRecord::Migration
  def change
    rename_column :shipments, :prefecture, :prefecture_code
  end
end
