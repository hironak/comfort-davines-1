class CreateRitous < ActiveRecord::Migration
  def change
    create_table :ritous do |t|
      t.string :postalcode
      t.string :city
      t.string :address

      t.timestamps
    end
  end
end
