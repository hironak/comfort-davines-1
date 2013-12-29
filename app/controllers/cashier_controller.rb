class CashierController < ApplicationController

  before_filter :protect_empty_cart, only: [:index]
  before_filter :set_order, except: [:index, :complete]

  def index
    @order = Order.new
    @order.extend_items current_cart
    session_save_order
    redirect_to cashier_order_path
  end

  def sample
  end

  def sample_craete
    @order.attributes = order_params
    session_save_order
    redirect_to cashier_order_path
  end

  def order
  end

  def order_create
    @order.attributes = order_params
    session_save_order
    redirect_to cashier_payment_path
  end

  def payment
  end

  def payment_create
    @order.attributes = payment_params
    session_save_order
    redirect_to cashier_confirm_path
  end

  def confirm
  end

  def confirm_create
    @order.save
    current_cart.clear
    session_clear_order
    redirect_to cashier_complete_path
  end

  def complete
  end

  private

  def protect_empty_cart
    redirect_to root_path and return unless current_cart.items.size > 0
  end

  def set_order
    @order = Order.new(session[:cashing_order])
    raise Order::ItemEmpty unless @order.items.size > 0
  end

  def session_save_order
    session[:cashing_order] = @order.to_hash
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
