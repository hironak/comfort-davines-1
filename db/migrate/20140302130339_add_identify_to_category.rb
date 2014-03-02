class AddIdentifyToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :identify, :string
  end
end
