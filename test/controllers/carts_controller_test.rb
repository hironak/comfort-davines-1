require "test_helper"

class CartsControllerTest < ActionController::TestCase

  before do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should post add" do
    post :add, { product_id: @product.id, amount: 1 }
    assert_redirected_to carts_path
  end

  test "should patch increment" do
    patch :increment, { product_id: @product.id }
    assert_redirected_to carts_path
  end

  test "should patch decrement" do
    patch :decrement, { product_id: @product.id }
    assert_redirected_to carts_path
  end

  test "should delete remove" do
    delete :remove, { product_id: @product.id }
    assert_redirected_to carts_path
  end

  test "l should get index" do
    @consumer = create(:consumer)
    @consumer.confirm!
    sign_in @consumer
    get :index
    assert_response :success
  end

  test "l should post add" do
    @consumer = create(:consumer)
    @consumer.confirm!
    sign_in @consumer
    post :add, { product_id: @product.id, amount: 1 }
    assert_redirected_to carts_path
  end

  test "l should patch increment" do
    @consumer = create(:consumer)
    @consumer.confirm!
    sign_in @consumer
    patch :increment, { product_id: @product.id }
    assert_redirected_to carts_path
  end

  test "l should patch decrement" do
    @consumer = create(:consumer)
    @consumer.confirm!
    sign_in @consumer
    patch :decrement, { product_id: @product.id }
    assert_redirected_to carts_path
  end

  test "l should delete remove" do
    @consumer = create(:consumer)
    @consumer.confirm!
    sign_in @consumer
    delete :remove, { product_id: @product.id }
    assert_redirected_to carts_path
  end

end
