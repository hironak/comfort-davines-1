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
    if self.items_price >= 6000 * Setting.tax_rate
      0
    else
      if self.respond_to?(:shipment) && self.shipment && self.shipment.postage_extra?
        1000 * Setting.tax_rate
      else
        500 * Setting.tax_rate
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
        300 * Setting.tax_rate
      when total <= 30000
        400 * Setting.tax_rate
      when total <= 100000
        600 * Setting.tax_rate
      when total <= 300000
        1000 * Setting.tax_rate
      when total <= 500000
        2000 * Setting.tax_rate
      when total <= 1000000
        3000 * Setting.tax_rate
      else
        4000 * Setting.tax_rate
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
