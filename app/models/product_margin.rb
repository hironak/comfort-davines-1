class ProductMargin < ActiveRecord::Base
  belongs_to :product
  belongs_to :agency

  validates :product_id, presence: true
  validates :agency_id, presence: true

  delegate :name, to: :product
end
