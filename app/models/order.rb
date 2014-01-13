class Order < ActiveRecord::Base
  include Pricing
  include Regulating

  belongs_to :consumer
  has_many :items, class_name: 'OrderItem', dependent: :delete_all
  has_many :products, through: :items

  belongs_to :salon
  before_save :set_salon

  accepts_nested_attributes_for :items, allow_destroy: true

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

  def set_salon
    if salon_name.present? && salon = Salon.where(name: salon_name).first
      self.salon_id = salon.id
    end
  end

  class ItemEmpty < StandardError
  end
end
