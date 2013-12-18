class CashierController < ApplicationController
  def order
  end

  def order_create
    redirect_to cashier_payment_url
  end

  def payment
  end

  def payment_create
    redirect_to cashier_confirm_url
  end

  def confirm
  end

  def confirm_create
    redirect_to cashier_complete_url
  end

  def complete
  end
end
