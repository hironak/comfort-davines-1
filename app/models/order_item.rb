class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  include Pricing::Item

  def backmargin(type)
    return 0 unless self.send("backmargin_#{type}").present?
    (price.to_f * (self.send("backmargin_#{type}").to_f / 100)).to_i
  end
end
