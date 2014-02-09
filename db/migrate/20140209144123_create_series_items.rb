class CreateSeriesItems < ActiveRecord::Migration
  def change
    create_table :series_items do |t|
      t.string :name
      t.references :series, index: true

      t.timestamps
    end
  end
end
