require "test_helper"

class Administration::SettingsControllerTest < ActionController::TestCase
  before do
    create(:setting)
    login_user create(:administrator)
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get update" do
    patch :update, setting: { tax_percentage: 5 }
    assert_redirected_to admin_setting_path
  end

end
