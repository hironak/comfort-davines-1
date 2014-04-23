require "base64"

module Administration
  class BaseController < ApplicationController
    protect_from_forgery with: :exception

    layout "administration"

    before_filter :require_login

    helper_method :current_administrator

    helper_method :resource_name
    helper_method :resource

    def current_ability
      @current_ability ||= AdministratorAbility.new(current_administrator)
    end

    private

    def self.confirmation! resource_name
      @@resource_name = resource_name.to_s
      before_action :confirmation!, only: [:create, :update]
    end

    def confirmation!
      if params[:confirm] && resource.confirmable?
        session[:confirmation] ||= {}
        session[:confirmation][@@resource_name] = base64_encode(resource_params)
        render "confirm" and return false
      end
      if session[:confirmation] && session[@@resource_name]
        params.merge!(@@resource_name => base64_decode(session[:confirmation][@@resource_name]))
      end
    end

    def base64_encode hash
      ::Hash.new.tap do |new_hash|
        hash.each do |key, val|
          new_hash[key] =
            case val
            when ::ActionDispatch::Http::UploadedFile
              "exdata:#{val.content_type};#{val.original_filename};#{Base64.encode64(val.tempfile.read)}"
            when ::Hash
              base64_encode val
            else
              val
            end
        end
      end
    end

    def base64_decode hash
      hash
    end

    def resource_params
      send "#{@@resource_name}_params"
    end

    def resource
      @@resource ||= (
        if klass = @@resource_name.capitalize.constantize
          if params[:id]
            klass.find(params[:id])
          else
            klass.new
          end
      end
      ).tap do |resource|
        if params = resource_params
          resource.attributes =  params
        end
      end
    end

    def not_authenticated
      redirect_to admin_login_path, notice: I18n.t('administration_session.sign_in_required')
    end
  end
end
