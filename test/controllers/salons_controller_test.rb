require "test_helper"

class SalonsControllerTest < ActionController::TestCase

  before do
    @salon = create(:salon)
  end

  def test_index
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:salons)
  end

  # def test_new
  #   get :new
  #   assert_response :success
  # end

  # def test_create
  #   assert_difference('Salon.count') do
  #     post :create, salon: {  }
  #   end

  #   assert_redirected_to salon_path(assigns(:salon))
  # end

  # def test_show
  #   get :show, id: @salon
  #   assert_response :success
  # end

  # def test_edit
  #   get :edit, id: @salon
  #   assert_response :success
  # end

  # def test_update
  #   put :update, id: @salon, salon: {  }
  #   assert_redirected_to salon_path(assigns(:salon))
  # end

  # def test_destroy
  #   assert_difference('Salon.count', -1) do
  #     delete :destroy, id: @salon
  #   end

  #   assert_redirected_to salons_path
  # end
end
