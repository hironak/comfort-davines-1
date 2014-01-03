class AddRenderTypeToPage < ActiveRecord::Migration
  def change
    add_column :pages, :render_type, :string
  end
end
