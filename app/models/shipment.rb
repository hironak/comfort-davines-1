class Shipment < ActiveRecord::Base
  belongs_to :order

  validates :family_name, presence: true
  validates :family_name_kana, presence: true
  validates :given_name, presence: true
  validates :given_name_kana, presence: true

  validates :prefecture, presence: true
  validates :address, presence: true
  validates :building, presence: true

  validates :phone, presence: true

  def complete_address
    "#{self.prefecture} #{self.address} #{self.building}"
  end

  def postage_extra?
    self.prefecture == '沖縄県'
  end
end
