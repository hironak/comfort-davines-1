class Order < ActiveRecord::Base
  has_many :items, :class_name => 'OrderItem'

  def extend_items cart
    cart.items.each do |item|
      self.items.build product_id: item.product_id, amount: item.amount
    end
  end
end
