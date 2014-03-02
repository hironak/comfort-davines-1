class AddSingletonToSeries < ActiveRecord::Migration
  def change
    add_reference :serieses, :singleton, index: true
  end
end
