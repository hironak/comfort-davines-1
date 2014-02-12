class AddIdentifyToPage < ActiveRecord::Migration
  def change
    add_column :pages, :identify, :string
  end
end
