class Shipment < ActiveRecord::Base
  belongs_to :order

  def complete_address
    "#{self.prefecture} #{self.address} #{self.building}"
  end
end
