class CreatePressReleases < ActiveRecord::Migration
  def change
    create_table :press_releases do |t|
      t.string :magazine
      t.string :corner
      t.text :products

      t.timestamps
    end
  end
end
