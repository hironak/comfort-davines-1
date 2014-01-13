class CreateSalons < ActiveRecord::Migration
  def change
    create_table :salons do |t|
      t.string :name
      t.references :administrator, index: true

      t.timestamps
    end
  end
end
