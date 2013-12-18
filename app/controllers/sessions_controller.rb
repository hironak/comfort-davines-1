class SessionsController < Devise::SessionsController
  before_filter :update_cart, only: [:create]

  private

  # update_cart
  def update_cart
  end
end
