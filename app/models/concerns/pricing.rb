module Pricing
  extend ActiveSupport::Concern

  def total_price
    (items_price + tax + postage).to_i
  end

  def tax
    (items_price * (Setting.tax.to_f / 100)).to_i
  end

  def postage
    self.items.map(&:amount).inject(:+).to_i * 300
  end

  def items_price
    self.items.map(&:price).inject(:+).to_i
  end
end
