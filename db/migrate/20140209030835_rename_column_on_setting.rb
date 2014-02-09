class RenameColumnOnSetting < ActiveRecord::Migration
  def change
    rename_column :settings, :tax, :tax_percentage
  end
end
