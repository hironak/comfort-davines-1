class Product::Review < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  belongs_to :product

  default_scope -> { where(accepted: true) }
end
