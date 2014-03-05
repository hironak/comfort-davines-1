class AddImageToNews < ActiveRecord::Migration
  def self.up
    add_attachment :news_releases, :image
  end

  def self.remove
    remove_attachment :news_releases, :image
  end
end
