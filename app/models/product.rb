class Product < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  include Confirmable

  extend FriendlyId
  friendly_id :name

  has_and_belongs_to_many :serieses
  has_and_belongs_to_many :categories, join_table: :products_categories
  has_and_belongs_to_many :solutions

  belongs_to :template
  belongs_to :page

  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true, limit: 4

  belongs_to :plusone, class_name: 'Product'

  has_many :reviews

  has_many :margins, class_name: 'ProductMargin'

  scope :available, -> { where(sample: false, invisible: false) }
  scope :stocked, -> { where('stock > 0') }
  scope :sample, -> { where(sample: true) }

  scope :new_items, -> { available.where(new_item: true).limit(3) }
  scope :ranking, -> { available.order(ranking: :desc).limit(3) }

  serialize :recommendation_ids

  after_initialize :set_default_values
  def set_default_values
    self.backmargin_salon ||= 30
    self.backmargin_agency ||= 28
  end

  def series
    self.serieses.first
  end

  def category
    self.categories.first
  end

  def image *args
    (self.photos.first || self.photos.new).image *args
  end

  def admin_name
    if self.sample
      "#{name} <サンプル>"
    else
      name
    end
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
    raise DecreasingError if stock < 0
    # TODO: 一定数以下になったら通知する
    update_column :stock, stock
  end

  def self.last_updated_at
    self.order(updated_at: :desc).first.updated_at
  end

  def recommendations
    if self.recommendation_ids
      Product.find(self.recommendation_ids)
    else
      Product.available.limit(4).load
    end
  end

  def showable?
    !self.sample
  end

  def singleton?
    self.series.singleton == self
  end

  def label_simple
    self.label.gsub(/[＊\*]\d/, '')
  end

  def backmargin_agency
  end

  def backmargin_salon
  end

  class DecreasingError < ActiveRecord::ActiveRecordError
  end
end
