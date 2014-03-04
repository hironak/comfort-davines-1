require "test_helper"

class Administration::TopicsControllerTest < ActionController::TestCase

  before do
    @administration_topic = administration_topics(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_topics)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Administration::Topic.count') do
      post :create, administration_topic: {  }
    end

    assert_redirected_to administration_topic_path(assigns(:administration_topic))
  end

  def test_show
    get :show, id: @administration_topic
    assert_response :success
  end

  def test_edit
    get :edit, id: @administration_topic
    assert_response :success
  end

  def test_update
    put :update, id: @administration_topic, administration_topic: {  }
    assert_redirected_to administration_topic_path(assigns(:administration_topic))
  end

  def test_destroy
    assert_difference('Administration::Topic.count', -1) do
      delete :destroy, id: @administration_topic
    end

    assert_redirected_to administration_topics_path
  end
end
