class Cart < ActiveRecord::Base
  has_one :consumer
  has_many :items, :class_name => 'CartItem'
end
