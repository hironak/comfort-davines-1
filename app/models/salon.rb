class Salon < ActiveRecord::Base
  has_one :administrator, as: :contractable
  has_many :orders
  has_and_belongs_to_many :agencies
end
