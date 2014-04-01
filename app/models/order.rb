class Order < ActiveRecord::Base

  STATUSES = {
    'フォーム入力中' => :cashier,
    '新規作成' => :created,
    '発送処理中' => :arranging,
    '発送済み' => :shipped,
    '取消' => :deleted,
  }.freeze

  LISTABLE_STATUSES = STATUSES.dup.tap do |statuses|
    statuses.delete 'フォーム入力中'
  end.freeze

  CHANGABLE_STATUSES = STATUSES.dup.tap do |statuses|
    statuses.delete 'フォーム入力中'
    statuses.delete '新規作成'
  end.freeze

  TOTALING_STATUSES = STATUSES.dup.tap do |statuses|
    statuses.delete 'フォーム入力中'
    statuses.delete '取消'
  end.freeze

  DELIVERY_TIMES = {
    '指定なし' => '',
    '午前中' => '08',
    '12〜14時' => '12',
    '14〜16時' => '14',
    '16〜18時' => '16',
    '18〜20時' => '18',
    '19〜21時' => '19'
  }

  attr_accessor :phase

  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  include Pricing
  include Regulating

  belongs_to :consumer
  has_one :information, through: :consumer, class_name: 'Consumer::Information'

  has_many :items, class_name: 'OrderItem', dependent: :delete_all
  has_many :products, through: :items

  belongs_to :salon
  after_initialize :set_salon_prefecture
  before_save :set_salon

  has_one :shipment
  before_save :save_email

  belongs_to :payment, polymorphic: true, dependent: :destroy

  accepts_nested_attributes_for :shipment, allow_destroy: true
  accepts_nested_attributes_for :payment, allow_destroy: true
  accepts_nested_attributes_for :items, allow_destroy: true

  scope :listable, -> { where(status: LISTABLE_STATUSES.values) }
  scope :changable, -> { where(status: LISTABLE_STATUSES.values) }
  scope :totaling, -> { where(status: TOTALING_STATUSES.values) }

  after_initialize :set_options
  before_save :set_options

  validates :items, length: { minimum: 1 }, if: :phase_initialize?

  validates :samples, length: { maximum: 2 }, if: :phase_sample?

  validates :salon_name, presence: true, unless: :salon_not_found, if: :phase_shipment?
  validates :shipment,   presence: true, if: :phase_shipment?

  validates :payment,  presence: true, if: :phase_payment?

  validates :delivery_date, inclusion: { in: -> order { (4.day.since.to_date...1.month.since.to_date).map{|d| I18n.l(d) } }, allow_blank: true }, on: :create, if: :phase_confirm?
  validates :delivery_time, inclusion: { in: DELIVERY_TIMES.values }, if: :phase_confirm?

  def number
    "DD#{"%010d" % self.id}"
  end

  def items_without_samples
    if self.persisted?
      self.items.without_samples
    else
      self.items.select{|item| !item.product.sample }
    end
  end

  def samples
    if self.persisted?
      self.items.joins(:product).where(products: { sample: true })
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

  def sample_ids
    self.samples.map(&:id)
  end

  def sample_ids= ids
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

  def delivery_time_human
    DELIVERY_TIMES.key(self.delivery_time)
  end

  def save_payment
    if self.payment && payment.save
      self.payment_id = payment.id
    end
  end

  def to_hash
    self.attributes.dup.tap do |hash|
      hash["sample_selected"] = self.sample_selected
      hash["shipment_attributes"] = self.shipment.attributes if self.shipment
      hash["items_attributes"] = self.items.map(&:attributes)
    end
  end

  def confirm
    save_payment
    if self.phase_confirm?
      self.items.each do |item|
        item.product.decrease item.amount
      end
      self.save
    end
  end

  def set_salon
    if salon_name.present? && salon = Salon.where(name: salon_name).first
      self.salon_id = salon.id
    end
  end

  def payment_capture
    if phase_confirm? && self.payment && self.payment.class == Payment::Creditcard
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
    initialize_ready? && (self.phase = 'sample') && self.sample_selected && self.valid? || (self.phase = nil)
  end

  def initialize_ready?
    self.items.size > 0
  end

  def load_consumer_information
    if self.consumer && self.consumer.information && !self.shipment
      attributes = self.consumer.information.attributes
      attributes.delete "id"
      attributes.delete "consumer_id"
      attributes.delete "created_at"
      attributes.delete "updated_at"
      self.build_shipment(attributes)
    end
  end

  private

  def set_options
    unless self.finalized?
      self.postage = compute_postage
      self.commission = compute_commission
    else
      self.postage ||= compute_postage
      self.commission ||= compute_commission
    end
  end

  def set_salon_prefecture
    self.salon_prefecture ||= self.consumer.try(:information).try(:prefecture).try(:name)
  end

  def save_email
    self.email = self.consumer.try :email
  end
end
