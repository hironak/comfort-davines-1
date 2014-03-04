class AddAnnotationToProduct < ActiveRecord::Migration
  def change
    add_column :products, :annotation, :text
  end
end
