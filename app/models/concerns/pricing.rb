module Pricing
  extend ActiveSupport::Concern

  def total_price
    (items_price + postage).to_i
  end

  def tax
    self.items.map(&:tax).inject(:+).to_i
  end

  def postage
    if self.items_price > 6000
      0
    else
      postage_extra
    end
  end

  def items_price
    self.items.map(&:price).inject(:+).to_i
  end

  private

  def postage_extra
    if false
    else
      525
    end
  end
end
