class Series < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  self.table_name = "series"

  has_and_belongs_to_many :products
end
