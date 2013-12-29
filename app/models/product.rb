class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  scope :avaiable, -> { where(sample: false) }
  scope :sample, -> { where(sample: true) }
end
