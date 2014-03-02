class Product < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  extend FriendlyId
  friendly_id :name

  has_and_belongs_to_many :serieses
  has_and_belongs_to_many :categories, join_table: :products_categories
  has_and_belongs_to_many :solutions

  belongs_to :template
  belongs_to :page

  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true, limit: 4

  has_many :reviews

  scope :available, -> { where(sample: false) }
  scope :stocked, -> { where.not(stock: 0) }
  scope :sample, -> { where(sample: true) }

  after_initialize :set_default_values
  def set_default_values
    self.backmargin_salon ||= 30
    self.backmargin_agency ||= 28
  end

  def series
    self.serieses.first
  end

  def catalog_classes
    self.categories.map{|c| "category_#{c.id}" } + [self.template.identify, "#{self.series.identify}-item"]
  end

  def category
    self.categories.first
  end

  def image *args
    (self.photos.first || self.photos.new).image *args
  end

  def view_price
    (self.price * Setting.tax_rate).to_i
  end

  def view_price= price
    self.price = (price.to_f / Setting.tax_rate).to_i
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

  def self.last_updated_at
    self.order(updated_at: :desc).first.updated_at
  end

  def plusone
    Product::OiOil.available.first
  end

  def recommendations
    Product.available.limit(4).load
  end

  def showable?
    !self.sample
  end

  def singleton?
    self.series.singleton == self
  end
end
