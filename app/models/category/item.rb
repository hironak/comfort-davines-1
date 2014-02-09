class Category::Item < ActiveRecord::Base
  belongs_to :category
end
