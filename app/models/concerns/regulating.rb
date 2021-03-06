module Regulating
  extend ActiveSupport::Concern

  def add product, amount
    item = find_item_by_product product
    item.update_attributes amount: amount
  end

  def remove product
    item = find_item_by_product product
    item.destroy
  end

  def increment product
    item = find_item_by_product product
    item.increment
  end

  def decrement product
    item = find_item_by_product product
    item.decrement
  end

  def clear
    items.delete_all
  end

  private

  def find_item_by_product(product)
    self.items.where(product_id: product.id).first_or_create
  end
end
