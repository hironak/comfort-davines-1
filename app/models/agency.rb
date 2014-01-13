class Agency < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  has_one :administrator, as: :contractable
  has_and_belongs_to_many :salons
end
