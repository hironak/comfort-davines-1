module Pricing::Item
  extend ActiveSupport::Concern

  included do
    self.scope :samples, -> { includes(:product).where(products: { sample: true }) }
    self.scope :without_samples, -> { includes(:product).where(products: { sample: false }) }
  end


  def view_origin_price
    (self.origin_price * Setting.tax_rate).to_i
  end

  def price
    (self.origin_price * Setting.tax_rate).to_i * self.amount
  end

  def tax
    (self.origin_price * Setting.tax).to_i * self.amount
  end

  def check_amount
    self.amount <= self.product.stock
  end
end
