class Order < ActiveRecord::Base

  STATUSES = {
    '新規作成' => :created,
    '発送済み' => :shipped,
  }

  attr_accessor :phase

  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  include Pricing
  include Regulating

  belongs_to :consumer
  has_many :items, class_name: 'OrderItem', dependent: :delete_all
  has_many :products, through: :items

  belongs_to :salon
  before_save :set_salon

  has_one :shipment

  belongs_to :payment, polymorphic: true, dependent: :destroy
  before_save :payment_capture

  accepts_nested_attributes_for :shipment, allow_destroy: true
  accepts_nested_attributes_for :payment, allow_destroy: true
  accepts_nested_attributes_for :items, allow_destroy: true

  validates :items, length: { minimum: 1 }, if: :phase_initialize?

  validates :samples, length: { minimum: 1, maximum: 2 }, if: :phase_sample?

  validates :salon_name, presence: true, unless: :salon_not_found, if: :phase_shipment?
  validates :shipment,   presence: true, if: :phase_shipment?

  validates :payment,  presence: true, if: :phase_payment?

  def items_without_samples
    if self.persisted?
      self.items.without_samples
    else
      self.items.select{|item| !item.product.sample }
    end
  end

  def samples
    if self.persisted?
      self.items.samples
    else
      self.items.select{|item| item.product.sample }
    end
  end

  def samples= items
    if self.persisted?
      self.samples.delete_all
    else
      self.samples.each do |item|
        self.items.delete(item)
      end
    end
    items.each do |item|
      self.items << item
    end
  end

  def select_samples ids
    products = Product.sample.where(id: ids)
    self.samples = products.map do |product|
      OrderItem.new(product_id: product.id, amount: 1, origin_price: product.price)
    end
  end

  def extend_items(cart)
    cart.items.each do |item|
      self.items.build(
        product_id: item.product.id,
        amount: item.amount,
        origin_price: item.product.price,
        backmargin_salon: item.product.backmargin_salon,
        backmargin_agency: item.product.backmargin_agency
      )
    end
  end

  def save_payment
    if self.payment && payment.save
      self.payment_id = payment.id
    end
  end

  def to_hash
    self.attributes.dup.tap do |hash|
      hash["shipment_attributes"] = self.shipment.attributes if self.shipment
      hash["items_attributes"] = self.items.map(&:attributes)
    end
  end

  after_save :decrease_product_stock
  def decrease_product_stock
    self.items.each do |item|
      item.product.decrease item.amount
    end
  end

  def set_salon
    if salon_name.present? && salon = Salon.where(name: salon_name).first
      self.salon_id = salon.id
    end
  end

  def payment_capture
    if self.payment && self.payment.class == Payment::Creditcard
      self.payment.charge_capture
    end
  end

  def backmargin(type)
    return 0 unless self.salon
    self.items.map{|item| item.backmargin(type) }.inject(:+)
  end

  class ItemEmpty < StandardError
  end

  def status_human
    STATUSES.key(self.status.to_sym)
  end

  def payment_type_human
    Payment::TYPES.key(self.payment_type)
  end

  def build_payment(params=nil, *assignment_options)
    raise "Unknown payment_type: #{payment_type}" unless Payment::TYPES.values.include?(payment_type)
    self.payment = payment_type.constantize.new(params)
  end

  def phase_confirm?
    !self.phase || (self.phase == 'confirm')
  end

  def phase_initialize?
    phase_confirm? || self.phase == 'initialize'
  end

  def phase_sample?
    phase_confirm? || self.phase == 'sample'
  end

  def phase_shipment?
    phase_confirm? || self.phase == 'shipment'
  end

  def phase_payment?
    phase_confirm? || self.phase == 'payment'
  end

  def payment_ready?
    shipment_ready? && (self.phase = 'payment') && self.valid? || (self.phase = nil)
  end

  def shipment_ready?
    sample_ready? && (self.phase = 'shipment') && self.valid? || (self.phase = nil)
  end

  def sample_ready?
    initialize_ready? && (self.phase = 'sample') && self.valid? || (self.phase = nil)
  end

  def initialize_ready?
    self.items.size > 0
  end
end
