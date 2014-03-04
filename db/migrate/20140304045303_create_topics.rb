class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.date :date
      t.string :subject
      t.string :url

      t.timestamps
    end
  end
end
