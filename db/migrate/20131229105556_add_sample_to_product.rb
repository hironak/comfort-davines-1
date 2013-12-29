class AddSampleToProduct < ActiveRecord::Migration
  def change
    add_column :products, :sample, :boolean, default: false
  end
end
