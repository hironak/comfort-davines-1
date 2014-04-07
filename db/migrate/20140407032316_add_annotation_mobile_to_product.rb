class AddAnnotationMobileToProduct < ActiveRecord::Migration
  def change
    add_column :products, :annotation_mobile, :text
  end
end
