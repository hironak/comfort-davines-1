class Shipment < ActiveRecord::Base
  belongs_to :order
  include Informationable
end
