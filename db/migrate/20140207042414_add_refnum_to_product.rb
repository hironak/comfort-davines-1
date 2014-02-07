class AddRefnumToProduct < ActiveRecord::Migration
  def change
    add_column :products, :refnum, :string
  end
end
