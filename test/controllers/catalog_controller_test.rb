require "test_helper"

class CatalogControllerTest < ActionController::TestCase
  test "should get series" do
    get :series
    assert_response :success
  end

  test "should get category" do
    get :category
    assert_response :success
  end

  test "should get solution" do
    get :solution
    assert_response :success
  end

end
