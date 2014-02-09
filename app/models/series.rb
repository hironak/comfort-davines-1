class Series < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  self.table_name = "series"

  has_many :items
  accepts_nested_attributes_for :items

  has_attached_file :topimage
end
