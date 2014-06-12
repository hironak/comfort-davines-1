class AddPostageFreeToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :postage_free, :boolean
  end
end
