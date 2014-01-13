class Administrator < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :contractable, polymorphic: true

  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end
