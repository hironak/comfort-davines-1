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

  def test_show
    get :show, id: @product
    assert_response :success
  end

end
