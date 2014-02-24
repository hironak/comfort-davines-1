class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_cart

  before_filter :default_title

  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

  def current_cart
    @current_cart ||= consumer_cart || session_cart
  end

  def consumer_cart
    current_consumer && current_consumer.find_or_build_cart
  end

  def session_cart
    @session_cart ||= Cart.where(id: session["cart.id"]).first || Cart.create
    session["cart.id"] = @session_cart.id
    @session_cart
  end

  def title string
    @title = "#{@default_title} - #{string}"
  end

  def default_title
    @default_title ||= "davines online"
  end

  def rmt successfull, verb, resource
    I18n.t("resource.#{successfull}.#{verb}", model: I18n.t("activerecord.models.#{resource.class.name.underscore}"))
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, information_attributes: [
        :family_name,
        :given_name,
        :family_name_kana,
        :given_name_kana,
        :postalcode,
        :prefecture_code,
        :address,
        :building,
        :phone,
      ])
    end
  end
end
