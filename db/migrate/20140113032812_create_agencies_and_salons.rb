class CreateAgenciesAndSalons < ActiveRecord::Migration
  def change
    create_table :agencies_and_salons do |t|
      t.belongs_to :agency, index: true
      t.belongs_to :salon, index: true
    end
  end
end
