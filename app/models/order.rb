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

  accepts_nested_attributes_for :items, allow_destroy: true

  def sample
    self.items.includes(:priduct).where(product: { sample: true } )
  end

  def select_sample params
    products = Product.sample.where(id: params[:samples])
    self.items = products.map do |product|
      self.sample_add OrderItem.new(product_id: product.id, amount: 1, origin_price: product.price)
    end
  end

  def extend_items cart
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

  def backmargin(type)
    return 0 unless self.salon
    self.items.map{|item| item.backmargin(type) }.inject(:+)
  end

  class ItemEmpty < StandardError
  end
end
