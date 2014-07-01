class Salon < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  include Rewardable

  has_one :administrator, as: :contractable
  has_many :orders
  belongs_to :agency
end
