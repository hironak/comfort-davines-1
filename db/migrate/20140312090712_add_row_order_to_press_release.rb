class AddRowOrderToPressRelease < ActiveRecord::Migration
  def change
    add_column :press_releases, :row_order, :integer
  end
end
