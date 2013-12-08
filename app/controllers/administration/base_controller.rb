class Administration::BaseController < ApplicationController
  protect_from_forgery with: :exception

  def current_ability
    @current_ability ||= AdminAbility.new(current_dealer)
  end
end
