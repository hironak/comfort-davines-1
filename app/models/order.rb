class Order < ActiveRecord::Base
  has_many :items, :class_name => 'OrderItem'

  accepts_nested_attributes_for :items, allow_destroy: true

  def total_price
    self.items.map(&:price).inject(:+)
  end

  def sample
    self.items.includes(:priduct).where(product: { sample: true } )
  end

  def sample= item
    self.items << item
  end

  def select_sample product
    self.sample = OrderItem.new(product_id: product.id, amount: 1, origin_price: product.price)
  end

  def extend_items cart
    cart.items.each do |item|
      self.items.build product_id: item.product.id, amount: item.amount, origin_price: item.product.price
    end
  end

  def to_hash
    hash = self.attributes
    hash["items_attributes"] = self.items.map(&:attributes)
    hash
  end

  after_save :decrease_product_stock
  def decrease_product_stock
    self.items.each do |item|
      item.product.decrease item.amount
    end
  end

  class ItemEmpty < StandardError
  end
end
