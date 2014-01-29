require "test_helper"

class MypageControllerTest < ActionController::TestCase
  before do
    sign_in consumers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get orders" do
    get :orders
    assert_response :success
  end

end
