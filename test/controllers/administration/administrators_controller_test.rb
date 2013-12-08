require "test_helper"

class Administration::AdministratorsControllerTest < ActionController::TestCase

  before do
    @administrator = administrators(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:administrators)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Administrator.count') do
      post :create, administrator: { username: "testuser"  }
    end

    assert_redirected_to admin_administrator_path(assigns(:administrator))
  end

  def test_show
    get :show, id: @administrator
    assert_response :success
  end

  def test_edit
    get :edit, id: @administrator
    assert_response :success
  end

  def test_update
    put :update, id: @administrator, administrator: { username: "testuser"  }
    assert_redirected_to admin_administrator_path(assigns(:administrator))
  end

  def test_destroy
    assert_difference('Administrator.count', -1) do
      delete :destroy, id: @administrator
    end

    assert_redirected_to admin_administrators_path
  end
end
