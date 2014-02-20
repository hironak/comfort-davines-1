class Shipment < ActiveRecord::Base
  belongs_to :order

  include JpPrefecture
  jp_prefecture :prefecture_code

  validates :family_name, presence: true
  validates :family_name_kana, presence: true
  validates :given_name, presence: true
  validates :given_name_kana, presence: true

  validates :prefecture_code, presence: true
  validates :address, presence: true
  validates :building, presence: true

  validates :phone, presence: true

  def complete_address
    "#{self.prefecture.name} #{self.address} #{self.building}"
  end

  def postage_extra?
    self.prefecture == '沖縄県'
  end
end
