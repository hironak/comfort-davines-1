class AddNameKanaToSalon < ActiveRecord::Migration
  def change
    add_column :salons, :name_kana, :string
  end
end
