class AddBackmarginToAgency < ActiveRecord::Migration
  def change
    add_column :agencies, :backmargin_agency, :integer
    add_column :agencies, :backmargin_salon, :integer
  end
end
