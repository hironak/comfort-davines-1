require "test_helper"

class Administration::RewardControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
