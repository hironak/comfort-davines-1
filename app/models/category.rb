class Category < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  has_and_belongs_to_many :products, join_table: :products_categories

  has_many :reviews, -> { uniq }, through: :products, class_name: 'Product::Review'
end
