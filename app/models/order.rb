class Order < ActiveRecord::Base
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

  validates :samples, length: { maximum: 2 }

  def samples
    if self.persisted?
      self.items.includes(:product).where(products: { sample: true } )
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

  searchable do
    text :address, :payment
    text :products do
      products.map(&:name)
    end

    boolean :sample do
      products.find(&:sample)
    end

    integer :total_price
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
    hash = self.attributes
    hash["items_attributes"] = self.items.map(&:attributes)
    hash
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

  def build_payment(params=nil, *assignment_options)
    raise "Unknown payment_type: #{payment_type}" unless Payment::TYPES.include?(payment_type)
    self.payment = payment_type.constantize.new(params)
  end
end
