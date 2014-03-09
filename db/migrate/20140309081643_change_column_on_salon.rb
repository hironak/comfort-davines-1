class ChangeColumnOnSalon < ActiveRecord::Migration
  def change
    change_column :salons, :name_kana, :text
  end
end
