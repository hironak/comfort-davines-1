class AddBodyToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :body, :text
  end
end
