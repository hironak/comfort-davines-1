class RemoveColumns2FromProduct < ActiveRecord::Migration
  def change
    remove_reference :products, :category, index: true
    remove_reference :products, :series, index: true
  end
end
