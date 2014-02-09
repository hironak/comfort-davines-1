class Shipment < ActiveRecord::Base
  belongs_to :order

  def complete_address
    "#{self.prefecture} #{self.address} #{self.building}"
  end

  def postage_extra?
    self.prefecture == '沖縄県'
  end
end
