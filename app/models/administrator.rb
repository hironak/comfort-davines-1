class Administrator < ActiveRecord::Base
  authenticates_with_sorcery!

  include Authority::UserAbilities

  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  belongs_to :contractable, polymorphic: true

  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: -> { password.present? }


  def admin?
    contractable_type == nil
  end

  def agency?
    contractable_type == "Agency"
  end

  def salon?
    contractable_type == "Salon"
  end
end
