class CreateNewsReleases < ActiveRecord::Migration
  def change
    create_table :news_releases do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
