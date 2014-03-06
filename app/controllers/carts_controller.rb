class CartsController < ApplicationController

  before_filter :set_product, only: [:add, :increment, :decrement, :remove]

  def index
    add_breadcrumb "ご注文手続き"
  end

  def add
    amount = params[:amount].to_i
    if @product.stock <= amount
      flash[:notice] = "在庫がありません"
      redirect_to action: :index and return
    end
    current_cart.add @product, amount
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
