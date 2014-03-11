require "kconv"

module Administration
  class OrdersController < BaseController
    authorize_actions_for Order

    before_action :set_order, only: [:show, :edit, :update, :destroy]

    # GET /administration/orders
    # GET /administration/orders.json
    def index
      params[:payment_type] = 'Payment::Deferred' if params[:output] == 'NP'
      @orders = Order.where.not(created_at: nil)
      if params[:status].present?
        @orders = @orders.where(status: params[:status])
      else
        @orders = @orders.where.not(status: :cashier)
      end
      @orders = @orders.where(payment_type: params[:payment_type]) unless params[:payment_type].blank?
      respond_to do |format|
        format.html { @orders = @orders.page(params[:page]) }
        format.csv do
          filename = if params[:output] == 'NP'
                       "orders-NP-#{Date.today.to_s}.csv"
                     else
                       "orders-#{Date.today.to_s}.csv"
                     end
          filename = ERB::Util.url_encode(filename)
          response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
          if params[:output] == 'NP'
            render "index_np"
          end
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
          format.html { redirect_to [:admin, @order], notice: rmt(:successfully, :updated, @order) }
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
      params.require(:order).permit(items_attributes: [:id, :amount, :_destroy])
    end
  end
end
