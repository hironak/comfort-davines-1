class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :tax

      t.timestamps
    end
  end
end
