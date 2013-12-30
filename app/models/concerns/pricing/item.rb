module Pricing::Item
  extend ActiveSupport::Concern

  def price
    self.origin_price * self.amount
  end
end
