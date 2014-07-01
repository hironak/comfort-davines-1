class RenameTableMarginToProductMargin < ActiveRecord::Migration
  def change
    rename_table :margins, :product_margins
  end
end
