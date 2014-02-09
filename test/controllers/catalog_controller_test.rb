require "test_helper"

class CatalogControllerTest < ActionController::TestCase

  test "should get series" do
    series = series(:one)
    get :series, id: series
    assert_response :success
  end

  test "should get category" do
    category = categories(:one)
    get :category, id: category
    assert_response :success
  end

  test "should get solution" do
    solution = create(:solution)
    get :solution, id: solution
    assert_response :success
  end

end
