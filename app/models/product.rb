class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  scope :avaiable, -> { where(sample: false) }
  scope :stocked, -> { where.not(stock: 0) }
  scope :sample, -> { where(sample: true) }

  def increase amount
    stock = self.stock + amount
    update_column :stock, stock
  end

  def decrease amount
    stock = self.stock - amount
    # TODO: 在庫がマイナスになったらエラー吐く？
    # TODO: 一定数以下になったら通知する
    update_column :stock, stock
  end
end
