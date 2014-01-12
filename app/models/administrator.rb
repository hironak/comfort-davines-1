class Administrator < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end
