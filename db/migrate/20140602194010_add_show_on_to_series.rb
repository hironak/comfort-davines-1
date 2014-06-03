class AddShowOnToSeries < ActiveRecord::Migration
  def change
    add_column :serieses, :show_on, :boolean, default: true
  end
end
