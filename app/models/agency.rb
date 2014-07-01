require "csv"

class Agency < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  include Rewardable

  has_one :administrator, as: :contractable
  accepts_nested_attributes_for :administrator, allow_destroy: false, update_only: true

  has_many :salons
  has_many :orders, through: :salons
  attr_accessor :salon_csv

  has_many :product_margins
  accepts_nested_attributes_for :product_margins

  validates :name, presence: true
  validates :backmargin_agency, presence: true
  validates :backmargin_salon, presence: true

  after_save :save_salons_from_csv

  def build_backmargins
    Product.available.each do |product|
      unless self.product_margins.map(&:product).include? product
        self.product_margins << ProductMargin.new(
          product: product,
          backmargin_agency: self.backmargin_agency,
          backmargin_salon: self.backmargin_salon)
      end
    end
  end

  private

  def save_salons_from_csv
    require "kconv"
    if self.salon_csv
      CSV.new(self.salon_csv.tempfile.read.toutf8, headers: :first_row).each do |attrs|

        attrs = attrs.to_hash

        puts attrs['name']
        puts attrs['name_kana']

        grades = { 'メンバー' => :member, 'プラチナ' => :platina, 'プレミアム' => :premium }
        attrs["grade"] = grades[attrs['grade']]

        if attrs['name']
          current_salon = Salon.find_or_initialize_by(number: attrs['number'])
          current_salon.attributes = attrs
        else
          attrs.each do |k, v|
            if v
              value = current_salon.send k
              value = "#{value}\r\n#{v}"
              current_salon.send "#{k}=", value
            end
          end
        end
        current_salon.agency_id = self.id
        current_salon.save
      end
    end
  end
end
