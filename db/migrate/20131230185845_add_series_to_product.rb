class AddSeriesToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :series, index: true
  end
end
