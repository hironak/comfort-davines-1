class Setting < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  def self.instance
    self.last
  end

  def self.method_missing method_name
    instance.send method_name
  end
end
