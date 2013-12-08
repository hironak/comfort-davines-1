module Administration
  class BaseController < ApplicationController
    protect_from_forgery with: :exception

    def current_ability
      @current_ability ||= AdministratorAbility.new(current_administrator)
    end
  end
end
