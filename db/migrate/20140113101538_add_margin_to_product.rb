class AddMarginToProduct < ActiveRecord::Migration
  def change
    add_column :products, :backmargin_salon, :integer
    add_column :products, :backmargin_agency, :integer
  end
end
