class AddIdentifyToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :identify, :string
  end
end
