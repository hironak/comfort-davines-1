class AddImageToPressRelaese < ActiveRecord::Migration
  def self.up
    add_attachment :press_releases, :image
  end

  def self.down
    remove_attachment :press_releases, :image
  end
end
