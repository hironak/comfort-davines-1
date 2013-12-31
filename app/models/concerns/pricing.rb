module Pricing
  extend ActiveSupport::Concern

  def total_price
    (items_price + tax + postage).to_i
  end

  def tax
    (items_price * 0.03).to_i
  end

  def postage
    self.items.map(&:amount).inject(:+) * 300
  end

  def items_price
    self.items.map(&:price).inject(:+)
  end
end
