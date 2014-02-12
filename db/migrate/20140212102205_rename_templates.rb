class RenameTemplates < ActiveRecord::Migration
  def change
    rename_table :product_templates, :templates
  end
end
