class CashierController < ApplicationController
  def order
    redirect_to action: :payment
  end

  def order_create
  end

  def payment
    redirect_to action: :confirm
  end

  def payment_create
  end

  def confirm
    redirect_to action: :complete
  end

  def confirm_create
  end

  def complete
  end
end
