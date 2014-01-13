class Salon < ActiveRecord::Base
  has_many :orders
end
