require "test_helper"

class CashierControllerTest < ActionController::TestCase
  before do
    cart_add products(:one), 1
  end

  test "should get index" do
    get :index
    assert_redirected_to cashier_sample_url
  end

  test "should get sample" do
    get :index
    get :sample
    assert_response :success
  end

  test "should post sample" do
    get :index
    get :sample
    post :sample_create
    assert_redirected_to cashier_order_url
  end

  test "should get order" do
    get :index
    get :order
    assert_response :success
  end

  test "should post order" do
    get :index
    get :order
    post :order_create, { order: { address: 'test' } }
    assert_redirected_to cashier_payment_url
  end

  test "should get payment" do
    get :index
    get :order
    post :order_create, { order: { address: 'test' } }
    get :payment
    assert_response :success
  end

  test "should post payment" do
    get :index
    get :order
    post :order_create, { order: { address: 'test' } }
    get :payment
    post :payment_create, { order: { payment: 'test' } }
    assert_redirected_to cashier_confirm_url
  end

  test "should get confirm" do
    get :index
    get :order
    post :order_create, { order: { address: 'test' } }
    get :payment
    post :payment_create, { order: { payment: 'test' } }
    get :confirm
    assert_response :success
  end

  test "should post confirm" do
    get :index
    get :order
    post :order_create, { order: { address: 'test' } }
    get :payment
    post :payment_create, { order: { payment: 'test' } }
    get :confirm
    post :confirm_create
    assert_redirected_to cashier_complete_url
  end

  test "should get complete" do
    get :index
    get :order
    post :order_create, { order: { address: 'test' } }
    get :payment
    post :payment_create, { order: { payment: 'test' } }
    get :confirm
    post :confirm_create
    get :complete
    assert_response :success
  end

end
