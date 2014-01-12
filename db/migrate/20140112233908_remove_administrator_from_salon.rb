class RemoveAdministratorFromSalon < ActiveRecord::Migration
  def change
    remove_reference :salons, :administrator, index: true
  end
end
