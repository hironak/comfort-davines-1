require "test_helper"

class Administration::ConsumersControllerTest < ActionController::TestCase

  before do
    @administration_consumer = administration_consumers(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_consumers)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Administration::Consumer.count') do
      post :create, administration_consumer: {  }
    end

    assert_redirected_to administration_consumer_path(assigns(:administration_consumer))
  end

  def test_show
    get :show, id: @administration_consumer
    assert_response :success
  end

  def test_edit
    get :edit, id: @administration_consumer
    assert_response :success
  end

  def test_update
    put :update, id: @administration_consumer, administration_consumer: {  }
    assert_redirected_to administration_consumer_path(assigns(:administration_consumer))
  end

  def test_destroy
    assert_difference('Administration::Consumer.count', -1) do
      delete :destroy, id: @administration_consumer
    end

    assert_redirected_to administration_consumers_path
  end
end
