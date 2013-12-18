class CartsController < ApplicationController

  before_filter :set_product, only: [:add, :increment, :decrement, :remove]

  def index
  end

  def add
    current_cart.add @product, params[:amount].to_i
    redirect_to action: :index
  end

  def increment
    current_cart.increment @product
    redirect_to action: :index
  end

  def decrement
    current_cart.decrement @product
    redirect_to action: :index
  end

  def remove
    current_cart.remove @product
    redirect_to action: :index
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
