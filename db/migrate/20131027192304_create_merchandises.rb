class CreateMerchandises < ActiveRecord::Migration
  def change
    create_table :merchandises do |t|
      t.integer :price

      t.timestamps
    end
  end
end
