class AddPlusoneToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :plusone, index: true
  end
end
