class Order < ActiveRecord::Base
  has_many :items, :class_name => 'OrderItem'

  accepts_nested_attributes_for :items, allow_destroy: true

  def extend_items cart
    cart.items.each do |item|
      self.items.build product_id: item.product_id, amount: item.amount
    end
  end

  def to_hash
    hash = self.attributes
    hash["items_attributes"] = self.items.map(&:attributes)
    hash
  end

  class ItemEmpty < StandardError
  end
end
