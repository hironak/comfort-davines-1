require "test_helper"

class MypageControllerTest < ActionController::TestCase
  before do
    @consumer = create(:consumer)
    @consumer.confirm!
    sign_in @consumer
  end

  test "should get information" do
    get :information
    assert_response :success
  end

end
