class Product < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  extend FriendlyId
  friendly_id :name

  belongs_to :page

  has_many :photos
  accepts_nested_attributes_for :photos

  scope :avaiable, -> { where(sample: false) }
  scope :stocked, -> { where.not(stock: 0) }
  scope :sample, -> { where(sample: true) }

  after_initialize :set_default_values
  def set_default_values
    self.backmargin_salon ||= 30
    self.backmargin_agency ||= 28
  end

  def image *args
    (self.photos.first || self.photos.new).image *args
  end

  def view_price
    (self.price * Setting.tax_rate).to_i
  end

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
