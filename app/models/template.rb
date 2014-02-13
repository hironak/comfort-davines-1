class Template < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  has_many :products

  include StrictDocument
  include StaticLoadable

  attr_static :header
  attr_static :style

  # validates :body, html: true
  validates :style, css: true
end
