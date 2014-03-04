require "test_helper"

class Administration::PressReleasesControllerTest < ActionController::TestCase

  before do
    login_user create(:administrator)
    @press_release = create(:press_release)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:press_releases)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('PressRelease.count') do
      post :create, press_release: attributes_for(:press_release)
    end

    assert_redirected_to admin_press_release_path(assigns(:press_release))
  end

  def test_show
    get :show, id: @press_release
    assert_response :success
  end

  def test_edit
    get :edit, id: @press_release
    assert_response :success
  end

  def test_update
    put :update, id: @press_release, press_release: attributes_for(:press_release)
    assert_redirected_to admin_press_release_path(assigns(:press_release))
  end

  def test_destroy
    assert_difference('PressRelease.count', -1) do
      delete :destroy, id: @press_release
    end

    assert_redirected_to admin_press_releases_path
  end
end
