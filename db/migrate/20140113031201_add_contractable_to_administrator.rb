class AddContractableToAdministrator < ActiveRecord::Migration
  def change
    add_column :administrators, :contractable_type, :string
    add_reference :administrators, :contract, index: true
  end
end
