class RenameSeries < ActiveRecord::Migration
  def change
    rename_table :series, :serieses
  end
end
