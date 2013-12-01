require "test_helper"

class MerchandisesControllerTest < ActionController::TestCase

  before do
    @merchandise = merchandises(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:merchandises)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Merchandise.count') do
      post :create, merchandise: { price: 1000 }
    end

    assert_redirected_to merchandise_path(assigns(:merchandise))
  end

  def test_show
    get :show, id: @merchandise
    assert_response :success
  end

  def test_edit
    get :edit, id: @merchandise
    assert_response :success
  end

  def test_update
    put :update, id: @merchandise, merchandise: { price: 1000 }
    assert_redirected_to merchandise_path(assigns(:merchandise))
  end

  def test_destroy
    assert_difference('Merchandise.count', -1) do
      delete :destroy, id: @merchandise
    end

    assert_redirected_to merchandises_path
  end
end
