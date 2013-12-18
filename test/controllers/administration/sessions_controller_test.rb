require "test_helper"

class Administration::SessionsControllerTest < ActionController::TestCase

  before do
    @administrator = Administrator.create username: "testuser", password: "password", password_confirmation: "password"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "session create" do
    post :create, username: "testuser", password: "password"
    assert_redirected_to admin_root_path
  end

  test "session destroy" do
    login_user @administrator
    delete :destroy
    assert_redirected_to admin_root_path
  end
end
