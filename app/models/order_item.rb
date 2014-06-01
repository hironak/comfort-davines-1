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
    return computed_margin send("backmargin_#{type}") if send("backmargin_#{type}").present?
    return computed_margin search_product_margin(type) if self.order.agency
    return 0
  end

  def search_product_margin(type)
    if margin = ProductMargin.find_by(product_id: self.product_id, agency_id: self.order.agency.id)
      margin.send("backmargin_#{type}")
    else
      search_origiin_margin(type)
    end
  end

  def search_origiin_margin(type)
    self.order.agency.send("backmargin_#{type}").to_i
  end

  def computed_margin(margin)
    (self.price.to_f * (margin.to_f / 100)).to_i
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
