class Agency < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  include Rewardable

  has_one :administrator, as: :contractable
  accepts_nested_attributes_for :administrator, allow_destroy: false, update_only: true

  has_and_belongs_to_many :salons
  has_many :orders, through: :salons

  after_initialize :set_defaults

  def set_defaults
    build_administrator unless administrator
  end
end
