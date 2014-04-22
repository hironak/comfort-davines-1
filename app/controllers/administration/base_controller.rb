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

    def self.confirmation! resource_name
      @@resource_name = resource_name.to_s
      before_action :confirmation!, only: [:create, :update]
    end

    def confirmation!
      if params[:confirm] && resource(resource_params).confirmable?
        render "confirm" and return false
      end
    end

    def resource_params
      if respond_to? "#{@@resource_name}_params"
        send "#{@@resource_name}_params"
      else
        params[@@resource_name]
      end
    end

    def resource(params = nil)
      resource =
        if klass = @@resource_name.capitalize.constantize
          if params[:id]
            klass.find(params[:id])
          else
            klass.new
          end
        end
      resource.tap do |resource|
        resource = params if params
      end
    end

    def not_authenticated
      redirect_to admin_login_path, notice: I18n.t('administration_session.sign_in_required')
    end
  end
end
