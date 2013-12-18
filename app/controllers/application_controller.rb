class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_cart
    cart_id = if current_consumer
                current_consumer.cart_id
              else
                session["cart.id"]
              end
  end
end
