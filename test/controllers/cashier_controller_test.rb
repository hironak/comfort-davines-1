require "test_helper"

class CashierControllerTest < ActionController::TestCase
  test "should get order" do
    get :order
    assert_response :success
  end

  test "should post order" do
    post :order_create
    assert_redirected_to cashier_payment_url
  end

  test "should get payment" do
    get :payment
    assert_response :success
  end

  test "should post payment" do
    post :payment_create
    assert_redirected_to cashier_confirm_url
  end

  test "should get confirm" do
    get :confirm
    assert_response :success
  end

  test "should post confirm" do
    post :confirm_create
    assert_redirected_to cashier_complete_url
  end

  test "should get complete" do
    get :complete
    assert_response :success
  end

end
