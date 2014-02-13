class Page < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  include StrictDocument
  include StaticLoadable

  attr_static :body
  attr_static :style

  # validates :body, html: true
  validates :style, css: true
end
