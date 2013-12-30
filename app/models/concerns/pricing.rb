module Pricing
  extend ActiveSupport::Concern

  def total_price
    self.items.map(&:price).inject(:+)
  end
end
