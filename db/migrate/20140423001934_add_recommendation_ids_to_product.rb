class AddRecommendationIdsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :recommendation_ids, :text
  end
end
