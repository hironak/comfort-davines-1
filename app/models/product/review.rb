class Product::Review < ActiveRecord::Base
  belongs_to :product

  default_scope -> { where(accepted: true) }
end
