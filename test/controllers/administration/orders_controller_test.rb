require "test_helper"

class Administration::OrdersControllerTest < ActionController::TestCase

  before do
    login_user administrators(:one)
    @order = orders(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  def test_show
    get :show, id: @order
    assert_response :success
  end

  def test_edit
    get :edit, id: @order
    assert_response :success
  end

  def test_update
    put :update, id: @order, order: { address: 'address', payment: 'payment', items_attributes: [ ]  }
    assert_redirected_to admin_order_path(assigns(:order))
  end

  def test_destroy
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to admin_orders_path
  end
end
