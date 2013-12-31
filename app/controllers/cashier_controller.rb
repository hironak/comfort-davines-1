class CashierController < ApplicationController

  before_filter :authenticate_consumer!, except: [:index, :signature, :signature_create]
  before_filter :protect_empty_cart, only: [:index]
  before_filter :set_order, except: [:index, :complete]

  def index
    @order = Order.new
    @order.extend_items current_cart
    session_save_order
    if consumer_signed_in?
      redirect_to cashier_sample_path
    else
      redirect_to cashier_signature_path
    end
  end

  def signature
    @consumer = Consumer.new
  end

  def signature_create
    case params[:signature]
    when "signup"
      binding.pry
      @consumer = Consumer.create consumer_params
    when "signin"
      @consumer = Consumer.find_for_authentication consumer_params
    end
    render "signature" and return unless @consumer

    sign_in @consumer
    redirect_to cashier_sample_path
  end

  def sample
  end

  def sample_create
    @order.select_sample Product.sample.find(sample_params)
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
    @order.consumer = current_consumer
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

  def sample_params
    params[:order][:sample]
  end

  def order_params
    params.require(:order).permit(:address)
  end

  def payment_params
    params.require(:order).permit(:payment)
  end

  private

  def consumer_params
    params.require(:consumer).permit(:email, :password, :password_confirmation)
  end
end
