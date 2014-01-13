# Other authorizers should subclass this one
class AdministrationAuthorizer < Authority::Authorizer

  # Any class method from Authority::Authorizer that isn't overridden
  # will call its authorizer's default method.
  #
  # @param [Symbol] adjective; example: `:creatable`
  # @param [Object] user - whatever represents the current user in your app
  # @return [Boolean]
  def self.default(adjective, administrator)
    administrator.admin?
  end

  def readable_by?(administrator)
    has_contractable(administrator) || administrator.admin?
  end

  def updatable_by?(administrator)
    has_contractable(administrator) || administrator.admin?
  end

  def has_contractable(administrator)
    case resource
    when Agency, Salon
      resource.administrator == administrator
    else
      false
    end
  end
end
