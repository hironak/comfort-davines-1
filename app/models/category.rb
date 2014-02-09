class Category < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  has_many :items
  accepts_nested_attributes_for :items
end
