require "csv"

class Agency < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  include Rewardable

  has_one :administrator, as: :contractable
  accepts_nested_attributes_for :administrator, allow_destroy: false, update_only: true

  has_and_belongs_to_many :salons
  has_many :orders, through: :salons
  attr_accessor :salon_csv

  validates :name, presence: true

  after_initialize :set_defaults

  before_save :save_salons_from_csv

  def set_defaults
    build_administrator unless administrator
  end

  private

  def save_salons_from_csv
    if self.salon_csv
      csv = CSV.new(self.salon_csv)
      csv.each do |row|

      end
    end
  end
end
