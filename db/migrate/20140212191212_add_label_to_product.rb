class AddLabelToProduct < ActiveRecord::Migration
  def change
    add_column :products, :label, :string
  end
end
