class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  include Pricing::Item
end
