class AddLabelColorToProduct < ActiveRecord::Migration
  def change
    add_column :products, :label_color, :string
  end
end
