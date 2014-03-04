class AddColumnsToProductReview < ActiveRecord::Migration
  def change
    add_column :product_reviews, :name, :string
    add_column :product_reviews, :subject, :string
  end
end
