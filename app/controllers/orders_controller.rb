class OrdersController < ApplicationController
  before_filter :authenticate_consumer!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    add_breadcrumb "マイページ", mypage_root_path
    add_breadcrumb "購入履歴"
    @orders = current_consumer.orders.listable
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    add_breadcrumb "マイページ", mypage_root_path
    add_breadcrumb "購入履歴", orders_path
    add_breadcrumb @order.number
  end

  # GET /orders/1/edit
  def edit
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_consumer.orders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params[:order]
    end
end
