module Informationable
  extend ActiveSupport::Concern

  included do
    self.send :include, JpPrefecture
    self.jp_prefecture :prefecture_code

    before_validation :normalize_postalcode

    validates :family_name, presence: true
    validates :family_name_kana, presence: true
    validates :given_name, presence: true
    validates :given_name_kana, presence: true

    validates :postalcode, format: { with: /\d{7}/ }
    validates :prefecture_code, presence: true
    validates :address, presence: true

    validates :phone, presence: true, format: { with: /\d{2,4}-\d{2,4}-\d{4}/ }
  end

  def name
    "#{self.family_name} #{self.given_name}"
  end

  def name_kana
    "#{self.family_name_kana} #{self.given_name_kana}"
  end

  def complete_address
    "#{self.prefecture.name} #{self.address} #{self.building}"
  end

  def postage_extra?
    self.prefecture == '沖縄県' || Ritou.include?(self.postalcode)
  end

  private

  def normalize_postalcode
    self.postalcode.gsub!(/-/, '')
  end
end
