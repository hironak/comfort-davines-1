class SessionsController < Devise::SessionsController

  around_filter :succeed_cart, only: [:create]

  private

  def succeed_cart
    session_cart
    yield
    current_consumer.cart.try :destroy
    session_cart.consumer = current_consumer
    session_cart.save
  end
end
