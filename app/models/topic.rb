class Topic < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  default_scope -> { order(created_at: :desc) }
  scope :available, -> { where("date < ?", Date.tomorrow).order(date: :desc) }
end
