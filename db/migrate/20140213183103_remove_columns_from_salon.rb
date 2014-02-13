class RemoveColumnsFromSalon < ActiveRecord::Migration
  def change
    remove_column :salons, :owner, :string
    remove_column :salons, :website, :string
    remove_column :salons, :office, :string
    remove_column :salons, :person_in_charge, :string
  end
end
