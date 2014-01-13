class AddContractableToAdministrator < ActiveRecord::Migration
  def change
    add_reference :administrators, :contractable, index: true, polymorphic: true
  end
end
