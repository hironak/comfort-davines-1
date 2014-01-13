module Administration
  class OrdersController < BaseController
    load_and_authorize_resource

    before_action :set_order, only: [:show, :edit, :update, :destroy]

    # GET /administration/orders
    # GET /administration/orders.json
    def index
      @orders = Order.all
      respond_to do |format|
        format.html
        format.csv do
          filename = "注文一覧-#{Date.today.to_s}.csv"
          filename = ERB::Util.url_encode(filename)
          response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
        end
      end
    end

    # GET /administration/orders/1
    # GET /administration/orders/1.json
    def show
    end

    # GET /administration/orders/1/edit
    def edit
    end

    # PATCH/PUT /administration/orders/1
    # PATCH/PUT /administration/orders/1.json
    def update
      respond_to do |format|
        if @order.update(order_params)
          format.html { redirect_to [:admin, @order], notice: 'Order was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/orders/1
    # DELETE /administration/orders/1.json
    def destroy
      @order.destroy
      respond_to do |format|
        format.html { redirect_to admin_orders_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:address, :payment, :items_attributes => [:id, :amount, :_destroy])
    end
  end
end
