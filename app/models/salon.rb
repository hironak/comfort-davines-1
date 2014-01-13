class Salon < ActiveRecord::Base
  has_one :administrator, as: :contractable
  has_many :orders
end
