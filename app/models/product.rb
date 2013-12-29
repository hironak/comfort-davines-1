class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  scope :avaiable, -> { where(sample: false) }
  scope :samples, -> { where(sample: true) }
end
