class AddAcceptedToProductReview < ActiveRecord::Migration
  def change
    add_column :product_reviews, :accepted, :boolean
  end
end
