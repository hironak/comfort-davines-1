class CashierController < ApplicationController

  before_filter :set_order, expect: [:complete]

  def order
  end

  def order_create
    @order.attributes = order_params
    session_save_order
    redirect_to cashier_payment_url
  end

  def payment
  end

  def payment_create
    @order.attributes = payment_params
    session_save_order
    redirect_to cashier_confirm_url
  end

  def confirm
  end

  def confirm_create
    @order.save
    current_cart.clear
    session_clear_order
    redirect_to cashier_complete_url
  end

  def complete
  end

  private

  def set_order
    @order = Order.new(session[:cashing_order])
    @order.extend_items current_cart
  end

  def session_save_order
    session[:cashing_order] = @order.attributes
  end

  def session_clear_order
    session[:cashing_order] = nil
  end

  def order_params
    params.require(:order).permit(:address)
  end

  def payment_params
    params.require(:order).permit(:payment)
  end
end
