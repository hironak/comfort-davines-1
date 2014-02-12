class AddTemplateToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :template, index: true
  end
end
