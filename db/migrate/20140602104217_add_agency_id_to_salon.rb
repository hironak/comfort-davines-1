class AddAgencyIdToSalon < ActiveRecord::Migration
  def change
    add_column :salons, :agency_id, :integer
  end
end
