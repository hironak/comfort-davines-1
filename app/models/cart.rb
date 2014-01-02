# class Cart
class Cart < ActiveRecord::Base
  include Pricing
  include Regulating

  belongs_to :consumer
  has_many :items, class_name: 'CartItem', dependent: :delete_all
  has_many :products, through: :items
end
