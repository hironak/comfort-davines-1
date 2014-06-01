require "test_helper"

class Administration::MarginsControllerTest < ActionController::TestCase

  before do
    @administration_margin = administration_margins(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_margins)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Administration::Margin.count') do
      post :create, administration_margin: {  }
    end

    assert_redirected_to administration_margin_path(assigns(:administration_margin))
  end

  def test_show
    get :show, id: @administration_margin
    assert_response :success
  end

  def test_edit
    get :edit, id: @administration_margin
    assert_response :success
  end

  def test_update
    put :update, id: @administration_margin, administration_margin: {  }
    assert_redirected_to administration_margin_path(assigns(:administration_margin))
  end

  def test_destroy
    assert_difference('Administration::Margin.count', -1) do
      delete :destroy, id: @administration_margin
    end

    assert_redirected_to administration_margins_path
  end
end
