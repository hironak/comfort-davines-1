module Pricing
  extend ActiveSupport::Concern

  # 総合計
  def total_price
    (items_price + postage + commission).to_i
  end

  # 消費税
  def tax
    self.items.map(&:tax).inject(:+).to_i
  end

  # 送料
  def compute_postage
    if self.items_price > 6000
      0
    else
      if self.respond_to?(:shipment) && self.shipment && self.shipment.postage_extra?
        1050
      else
        525
      end
    end
  end

  # 商品金額合計
  def items_price
    self.items.map(&:price).inject(:+).to_i
  end

  # 代引き手数料
  def compute_commission
    case self.payment_type
    when 'Payment::Collect'
      total = items_price + postage
      case
      when total <= 10000
        315
      when total <= 30000
        420
      when total <= 100000
        630
      when total <= 300000
        1050
      when total <= 500000
        2100
      when total <= 1000000
        3150
      else
        4200
      end
    else
      0
    end
  end

  def finalized?
    self.status.to_sym != :cashier
  end

  def check_amount
    !!self.items.all?(&:check_amount)
  end
end
