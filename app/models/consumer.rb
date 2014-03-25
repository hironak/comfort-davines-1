class Consumer < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :information
  accepts_nested_attributes_for :information
  has_one :cart
  has_many :orders

  after_initialize :initialize_setup

  def total
    orders.map(&:total_price).inject(:+).to_i
  end

  def initialize_setup
    self.information ||= Consumer::Information.new
  end

  def find_or_build_cart
    cart || create_cart
  end
end
