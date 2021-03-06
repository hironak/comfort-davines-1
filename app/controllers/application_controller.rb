class ApplicationController < ActionController::Base

  before_filter :skip_or_force_mobile

  include Mobylette::RespondToMobileRequests

  mobylette_config do |config|
    config[:skip_user_agents] = [:ipad]
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_cart

  before_filter :default_title

  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_filter :set_root_breadcrumb

  private

  def set_root_breadcrumb
    add_breadcrumb "HOME", root_path
  end

  def add_breadcrumb name, path=nil
    @breadcrumbs ||= []
    @breadcrumbs << [name, path]
  end

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
    @title = "#{string} | davines 公式オンラインショップ　【ダヴィネスダイレクト】"
  end

  def default_title
    @default_title ||= "イタリア・パルマ生まれのdavines 公式オンラインショップ【ダヴィネスダイレクト】"
  end

  def rmt successfull, verb, resource
    I18n.t("resource.#{successfull}.#{verb}", model: I18n.t("activerecord.models.#{resource.class.name.underscore}"))
  end

  def skip_or_force_mobile
    session[:mobylette_override] = :ignore_mobile if params[:skip_mobile]
    session[:mobylette_override] = :force_mobile  if params[:enable_mobile]
  end

  def mobile_headerless!
    @mobile_headerless = true
  end

  def mobile_lineupless!
    @mobile_lineupless = true
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :email,
        :password,
        :password_confirmation,
        :accepted_magazine,
        information_attributes: [
          :family_name,
          :given_name,
          :family_name_kana,
          :given_name_kana,
          :postalcode,
          :prefecture_code,
          :address,
          :building,
          :phone,
        ]
      )
    end
  end
end
