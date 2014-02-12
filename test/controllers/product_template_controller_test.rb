require "test_helper"

class ProductTemplateControllerTest < ActionController::TestCase
  test "should get stylesheets" do
    get :stylesheets
    assert_response :success
  end

end
