require "test_helper"

class ProductsControllerTest < ActionController::TestCase

  before do
    @product = create(:product)
  end

  def test_show
    get :show, id: @product
    assert_response :success
  end

end
