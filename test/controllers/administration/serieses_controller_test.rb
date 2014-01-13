require "test_helper"

class Administration::SeriesesControllerTest < ActionController::TestCase

  before do
    login_user create(:administrator)
    @series = series(:one)
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
    assert_difference('Series.count') do
      post :create, series: { name: 'New Series'  }
    end

    assert_redirected_to admin_series_path(assigns(:series))
  end

  def test_show
    get :show, id: @series
    assert_response :success
  end

  def test_edit
    get :edit, id: @series
    assert_response :success
  end

  def test_update
    put :update, id: @series, series: { name: 'Edit Series' }
    assert_redirected_to admin_series_path(assigns(:series))
  end

  def test_destroy
    assert_difference('Series.count', -1) do
      delete :destroy, id: @series
    end

    assert_redirected_to admin_serieses_path
  end
end
