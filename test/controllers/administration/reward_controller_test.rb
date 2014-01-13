require "test_helper"

class Administration::RewardControllerTest < ActionController::TestCase
  before do
    salon = create(:salon)
    login_user create(:administrator, contractable: salon)
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
