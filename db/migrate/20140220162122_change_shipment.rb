class ChangeShipment < ActiveRecord::Migration
  def change
    change_table :shipments do |t|
      t.remove :name
      t.string :family_name
      t.string :given_name
      t.string :family_name_kana
      t.string :given_name_kana

      t.remove :fax
    end
  end
end
