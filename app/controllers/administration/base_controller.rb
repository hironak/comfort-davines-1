module Administration
  class BaseController < ApplicationController



    protect_from_forgery with: :exception

    layout "administration"

    before_filter :require_login

    helper_method :current_administrator

    def current_ability
      @current_ability ||= AdministratorAbility.new(current_administrator)
    end

    private

    def not_authenticated
      redirect_to admin_login_path, alert: "Please login first"
    end
  end
end
