class CreateSolutionItems < ActiveRecord::Migration
  def change
    create_table :solution_items do |t|
      t.string :name
      t.references :solution, index: true

      t.timestamps
    end
  end
end
