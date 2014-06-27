require "test_helper"

class LandingControllerTest < ActionController::TestCase
  test "should get oioil" do
    get :oioil
    assert_response :success
  end

end
