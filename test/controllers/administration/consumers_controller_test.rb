require "test_helper"

class Administration::ConsumersControllerTest < ActionController::TestCase

  before do
    login_user create(:administrator)
    @consumer = create(:consumer)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:consumers)
  end

  # def test_new
  #   get :new
  #   assert_response :success
  # end

  # def test_create
  #   assert_difference('Consumer.count') do
  #     post :create, consumer: {  }
  #   end

  #   assert_redirected_to admin_consumer_path(assigns(:consumer))
  # end

  def test_show
    get :show, id: @consumer
    assert_response :success
  end

  # def test_edit
  #   get :edit, id: @consumer
  #   assert_response :success
  # end

  # def test_update
  #   put :update, id: @consumer, consumer: {  }
  #   assert_redirected_to consumer_path(assigns(:consumer))
  # end

  # def test_destroy
  #   assert_difference('Consumer.count', -1) do
  #     delete :destroy, id: @consumer
  #   end

  #   assert_redirected_to admin_consumers_path
  # end
end
