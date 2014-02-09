class Setting < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  def self.instance
    self.last || self.create(default_params)
  end

  def self.method_missing method_name
    instance.send method_name
  end

  def self.default_params
    { tax: 5 }
  end

  def tax_rate
    (1.0 + tax)
  end

  def tax
    (self.tax_percentage.to_f / 100)
  end
end
