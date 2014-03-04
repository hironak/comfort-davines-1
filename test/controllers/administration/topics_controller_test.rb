require "test_helper"

class Administration::TopicsControllerTest < ActionController::TestCase

  before do
    login_user create(:administrator)
    @topic = create(:topic)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Topic.count') do
      post :create, topic: attributes_for(:topic)
    end

    assert_redirected_to admin_topic_path(assigns(:topic))
  end

  def test_show
    get :show, id: @topic
    assert_response :success
  end

  def test_edit
    get :edit, id: @topic
    assert_response :success
  end

  def test_update
    put :update, id: @topic, topic: attributes_for(:topic)
    assert_redirected_to admin_topic_path(assigns(:topic))
  end

  def test_destroy
    assert_difference('Topic.count', -1) do
      delete :destroy, id: @topic
    end

    assert_redirected_to admin_topics_path
  end
end
