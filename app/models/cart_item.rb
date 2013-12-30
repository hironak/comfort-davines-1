class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  include Pricing::Item

  def origin_price
    self.product.price
  end

  def increment
    self.amount = 0 unless self.amount
    self.amount += 1
    save
  end

  def decrement
    self.amount = 0 unless self.amount
    self.amount -= 1
    if self.amount > 0
      save
    else
      destroy
    end
  end
end
