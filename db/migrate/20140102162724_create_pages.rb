class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :body
      t.text :style

      t.timestamps
    end
  end
end
