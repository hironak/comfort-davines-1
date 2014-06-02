class DropAgencysSalonsTable < ActiveRecord::Migration
  def change
    drop_table :agencies_salons
  end
end
