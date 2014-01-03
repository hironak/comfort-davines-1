class AddPageToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :page, index: true
  end
end
