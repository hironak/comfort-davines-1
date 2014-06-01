class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  include Pricing::Item

  before_save :set_tax_percentage

  scope :totaling, -> { select("order_items.*", "sum(order_items.amount) as amount").group(:product_id, :origin_price, :tax_percentage).join_orders } do
    def of_days start_date, end_date = nil
      end_date ||= start_date
      where(created_at: (start_date.midnight..end_date.at_end_of_day))
    end
  end
  scope :join_orders, -> { joins(:order).merge(Order.totaling) }

  def backmargin(type)
    return 0 unless self.send("backmargin_#{type}").present?
    if self.send("backmargin_#{type}").present?
      (price.to_f * (self.send("backmargin_#{type}").to_f / 100)).to_i
    elsif self.order.salon.present? && self.order.salon.agency.present?
      if margin = ProductMargin.find_by(product_id: self.product_id, agency_id: self.order.salon.agency.id)
        (price.to_f * (margin.send("backmargin_#{type}").to_f / 100)).to_i
      else
        0
      end
    else
      0
    end
  end

  def tax_rate
    (1.0 + tax)
  end

  def tax
    (self.tax_percentage.to_f / 100)
  end

  def set_tax_percentage
    self.tax_percentage = Setting.tax_percentage
  end
end
