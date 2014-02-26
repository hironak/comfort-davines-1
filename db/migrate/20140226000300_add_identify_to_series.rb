class AddIdentifyToSeries < ActiveRecord::Migration
  def change
    add_column :serieses, :identify, :string
  end
end
