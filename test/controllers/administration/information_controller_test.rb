require "test_helper"

class Administration::InformationControllerTest < ActionController::TestCase
  before do
    salon = create(:salon)
    login_user create(:administrator, contractable: salon)
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
    patch :update, salon: { name: 'Edit Name' }
    assert_redirected_to admin_information_path
  end

end
