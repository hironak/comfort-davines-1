module Pricing::Item
  extend ActiveSupport::Concern

  def price
    (self.origin_price * Setting.tax_rate).to_i * self.amount
  end

  def tax
    (self.origin_price * Setting.tax).to_i * self.amount
  end
end
