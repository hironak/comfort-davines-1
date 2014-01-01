class Cart < ActiveRecord::Base
  include Pricing
  include Regulating

  belongs_to :consumer
  has_many :items, class_name: 'CartItem', dependent: :delete_all
  has_many :products, through: :items

  def item_by_product(product)
    self.items.where(product_id: product.id).first_or_create
  end
end
