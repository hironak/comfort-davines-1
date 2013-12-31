class SessionsController < Devise::SessionsController

  around_filter :succeed_cart, only: [:create]

  private

  def succeed_cart
    session_cart
    yield
    if session_cart.items.count > 0
      current_consumer.cart.try :destroy
      session_cart.consumer = current_consumer
      session_cart.save
    end
  end
end
