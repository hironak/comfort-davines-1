class Series < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  self.table_name = "series"

  has_many :products

  has_many :items

  has_attached_file :topimage
end
