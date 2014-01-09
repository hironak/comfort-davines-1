require "test_helper"

class ProductsControllerTest < ActionController::TestCase

  before do
    @product = products(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  def test_category
    get :category
    assert_response :success
    assert_not_nil assigns(:products)
  end

  def test_series
    get :series
    assert_response :success
    assert_not_nil assigns(:products)
  end

  def test_new_items
    get :new_items
    assert_response :success
    assert_not_nil assigns(:products)
  end

  def test_show
    get :show, id: @product
    assert_response :success
  end

end
