class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_cart
    @current_cart ||= consumer_cart || session_cart
  end

  def consumer_cart
    current_consumer || current_consumer.find_or_build_cart
  end

  def session_cart
    cart =
      if session["cart_id"]
        Cart.find(session["cart.id"])
      else
        Cart.create
      end
    session["cart_id"] = cart.id
    cart
  end
end
