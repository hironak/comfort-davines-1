class Agency < ActiveRecord::Base
  has_one :administrator, as: :contractable
  has_and_belongs_to_many :salons
end
