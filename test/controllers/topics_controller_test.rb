require "test_helper"

class TopicsControllerTest < ActionController::TestCase

  before do
    @topic = create(:topic)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  def test_show
    get :show, id: @topic
    assert_response :success
  end
end
