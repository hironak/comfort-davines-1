class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  include Pricing::Item

  before_save :set_tax_percentage

  def self.sum
    self.all.map(&:price).inject(:+)
  end

  def backmargin(type)
    return 0 unless self.send("backmargin_#{type}").present?
    (price.to_f * (self.send("backmargin_#{type}").to_f / 100)).to_i
  end

  def tax_rate
    (1.0 + tax)
  end

  def tax
    (self.tax_percentage.to_f / 100)
  end

  def set_tax_percentage
    self.tax_percentage = Setting.tax_percentage
  end
end
