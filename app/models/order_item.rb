class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def price
    self.origin_price * self.amount
  end
end
