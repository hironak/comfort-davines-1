class Series < ActiveRecord::Base
  self.table_name = "series"

  has_many :products

  has_attached_file :topimage
end
