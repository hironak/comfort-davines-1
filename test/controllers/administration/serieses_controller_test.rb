require "test_helper"

class Administration::SeriesesControllerTest < ActionController::TestCase

  before do
    login_user administrators(:one)
    @seriese = series(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:serieses)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Seriese.count') do
      post :create, seriese: { name: 'New Series'  }
    end

    assert_redirected_to admin_seriese_path(assigns(:seriese))
  end

  def test_show
    get :show, id: @seriese
    assert_response :success
  end

  def test_edit
    get :edit, id: @seriese
    assert_response :success
  end

  def test_update
    put :update, id: @seriese, seriese: { name: 'Edit Series' }
    assert_redirected_to admin_seriese_path(assigns(:seriese))
  end

  def test_destroy
    assert_difference('Seriese.count', -1) do
      delete :destroy, id: @seriese
    end

    assert_redirected_to admin_serieses_path
  end
end
