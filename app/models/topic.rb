class Topic < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  scope :available, -> { where("date < ?", Date.tomorrow).order(date: :desc) }
end
