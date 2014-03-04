class AddDateToNewsRelease < ActiveRecord::Migration
  def change
    add_column :news_releases, :date, :date
  end
end
