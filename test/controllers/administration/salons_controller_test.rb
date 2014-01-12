require "test_helper"

class Administration::SalonsControllerTest < ActionController::TestCase

  before do
    login_user administrators(:one)
    @salon = create(:salon)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:salons)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Salon.count') do
      post :create, salon: { name: "Name" }
    end

    assert_redirected_to admin_salon_path(assigns(:salon))
  end

  def test_show
    get :show, id: @salon
    assert_response :success
  end

  def test_edit
    get :edit, id: @salon
    assert_response :success
  end

  def test_update
    put :update, id: @salon, salon: { name: "Name"  }
    assert_redirected_to admin_salon_path(assigns(:salon))
  end

  def test_destroy
    assert_difference('Salon.count', -1) do
      delete :destroy, id: @salon
    end

    assert_redirected_to admin_salons_path
  end
end
