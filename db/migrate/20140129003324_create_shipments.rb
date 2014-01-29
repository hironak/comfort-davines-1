class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :name
      t.string :postalcode
      t.string :prefecture
      t.string :address
      t.string :building
      t.string :phone
      t.string :fax

      t.timestamps
    end
  end
end
