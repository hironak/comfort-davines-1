class CreateMargins < ActiveRecord::Migration
  def change
    create_table :margins do |t|
      t.references :product, index: true
      t.references :agency, index: true
      t.integer :backmargin_salon
      t.integer :backmargin_agency

      t.timestamps
    end
  end
end
