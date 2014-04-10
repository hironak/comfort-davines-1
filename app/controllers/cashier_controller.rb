class CashierController < ApplicationController

  before_filter :mobile_headerless!
  before_filter :mobile_lineupless!
  before_filter :authenticate_consumer!, except: [:index, :signature, :signature_create]
  before_filter :protect_empty_cart, only: [:index]
  before_filter :set_order, except: [:index, :complete]
  before_filter :check_amount, except: [:index, :complete]
  before_filter :set_breadcrumb

  def index
    session_clear_order
    @order = Order.new
    @order.extend_items current_cart
    redirect_to carts_path, notice: "在庫がありません。" and return unless @order.check_amount
    @order.phase = 'initialize'
    check_amount
    session_save_order
    redirect_for @order
  end

  def sample
    redirect_for @order unless @order.initialize_ready?
  end

  def sample_create
    @order.phase = 'sample'
    @order.attributes = sample_params
    if session_save_order
      redirect_for @order
    else
      render 'sample'
    end
  end

  def shipment
    redirect_for @order unless @order.sample_ready?
  end

  def shipment_create
    @order.phase = 'shipment'
    @order.attributes = shipment_params
    if session_save_order
      redirect_for @order
    else
      render 'shipment'
    end
  end

  def payment
    redirect_for @order unless @order.shipment_ready?
  end

  def payment_create
    @order.phase = 'payment'
    @order.attributes = payment_params
    @order.payment.order = @order
    @order.payment.amount = @order.total_price
    if session_save_order
      redirect_for @order
    else
      render 'payment'
    end
  end

  def confirm
    redirect_for @order unless @order.payment_ready?
  end

  def confirm_create
    @order.attributes = confirm_params
    @order.status = :created
    render 'confirm' and return unless @order.confirm
    current_cart.clear
    session_clear_order
    OrderMailer.complete(current_consumer.email, @order).deliver
    session[:complete_order] = @order.id
    redirect_to cashier_complete_path
  end

  def complete
    root_path unless session[:complete_order]
    @order = Order.find(session[:complete_order])
    session[:complete_order] = nil
  end

  private

  def redirect_for order
    case
    when !consumer_signed_in?
      store_location_for :consumer, cashier_path
      redirect_to consumer_session_path
    when @order.payment_ready?
      redirect_to cashier_confirm_path
    when @order.shipment_ready?
      redirect_to cashier_payment_path
    when @order.sample_ready?
      redirect_to cashier_shipment_path
    when @order.initialize_ready?
      redirect_to cashier_sample_path
    else
      redirect_to cashier_path
    end
  end

  def protect_empty_cart
    redirect_to root_path and return unless current_cart.items.size > 0
  end

  def set_order
    @order = Order.find(session[:cashing_order_id]).tap do |order|
      if current_consumer
        order.consumer = current_consumer
        order.load_consumer_information
      end
    end
    raise Order::ItemEmpty unless @order.items.size > 0
  end

  def check_amount
    redirect_to carts_path, notice: "在庫がありません。" and return unless @order.check_amount
  end

  def session_save_order
    @order.status = :cashier
    if @order.save
      @order.save_payment
      session[:cashing_order_id] = @order.id
    else
      false
    end
  end

  def session_clear_order
    session[:cashing_order] = nil
  end

  def sample_params
    params.require(:order).permit(:sample_selected, sample_ids: [])
  end

  def shipment_params
    params.require(:order)
      .permit(
    :salon_prefecture,
    :salon_name,
    :salon_not_found,
    shipment_attributes: [
      :family_name,
      :given_name,
      :family_name_kana,
      :given_name_kana,
      :postalcode,
      :prefecture_code,
      :address,
      :building,
      :phone])
  end

  def payment_params
    payment_params = params.require(:order)
    case payment_params[:payment_type]
    when 'Payment::Creditcard'
      payment_params.permit(:payment_type, payment_attributes: [:card_number, :exp_month, :exp_year, :cvc, :name])
    when 'Payment::Deferred'
      payment_params.permit(:payment_type, payment_attributes: [:payment])
    when 'Payment::Collect'
      payment_params.permit(:payment_type, payment_attributes: [:payment])
    end
  end

  def consumer_params
    params.require(:consumer).permit(:email, :password, :password_confirmation)
  end

  def confirm_params
    params.require(:order).permit(:delivery_date, :delivery_time, :note)
  end

  def set_breadcrumb
    add_breadcrumb "ご注文手続き"
  end
end
