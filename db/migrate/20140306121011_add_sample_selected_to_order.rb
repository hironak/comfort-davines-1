class AddSampleSelectedToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :sample_selected, :boolean
  end
end
