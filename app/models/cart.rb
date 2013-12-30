class Cart < ActiveRecord::Base
  belongs_to :consumer
  has_many :items, :class_name => 'CartItem'

  include Pricing

  def item_by_product product
    self.items.where(product_id: product.id).first_or_create
  end

  def add product, amount
    item = item_by_product product
    item.update_attributes amount: amount
  end

  def remove product
    item = item_by_product product
    item.destroy
  end

  def increment product
    item = item_by_product product
    item.increment
  end

  def decrement product
    item = item_by_product product
    item.decrement
  end

  def clear
    items.delete_all
  end
end
