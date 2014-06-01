class ProductMargin < ActiveRecord::Base
  belongs_to :product
  belongs_to :agency

  delegate :name, to: :product
end
