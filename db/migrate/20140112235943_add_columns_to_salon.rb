class AddColumnsToSalon < ActiveRecord::Migration
  def change
    add_column :salons, :number, :string
    add_column :salons, :owner, :string
    add_column :salons, :office, :string
    add_column :salons, :person_in_charge, :string
    add_column :salons, :grade, :string
    add_column :salons, :address, :text
    add_column :salons, :tel, :string
    add_column :salons, :website, :string
  end
end
