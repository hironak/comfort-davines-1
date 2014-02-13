module Pricing::Item
  extend ActiveSupport::Concern

  def view_origin_price
    (self.origin_price * Setting.tax_rate).to_i
  end

  def price
    (self.origin_price * Setting.tax_rate).to_i * self.amount
  end

  def tax
    (self.origin_price * Setting.tax).to_i * self.amount
  end
end
