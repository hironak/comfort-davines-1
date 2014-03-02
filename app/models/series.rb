class Series < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  has_and_belongs_to_many :products

  has_many :categories, -> { uniq }, through: :products
  has_many :solutions, -> { uniq }, through: :products

  has_many :reviews, -> { uniq }, through: :products

  belongs_to :singleton, class_name: 'Product'
end
