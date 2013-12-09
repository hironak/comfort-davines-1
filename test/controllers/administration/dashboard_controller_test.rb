require "test_helper"

class Administration::DashboardControllerTest < ActionController::TestCase

  before do
    login_user administrators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
