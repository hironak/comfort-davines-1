class AddColumnsToConsumer < ActiveRecord::Migration
  def change
    add_column :consumers, :accepted_magazine, :boolean
    add_column :consumers, :accepted_terms, :boolean
  end
end
