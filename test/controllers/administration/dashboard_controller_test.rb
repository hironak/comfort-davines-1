require "test_helper"

class Administration::DashboardControllerTest < ActionController::TestCase

  before do
    login_user create(:administrator)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
