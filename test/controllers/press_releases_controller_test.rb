require "test_helper"

class PressReleasesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
