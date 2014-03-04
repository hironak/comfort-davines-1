require "test_helper"

class Administration::NewsReleasesControllerTest < ActionController::TestCase

  before do
    login_user create(:administrator)
    @news_release = create(:news_release)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:news_releases)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('NewsRelease.count') do
      post :create, news_release: { date: "2013-10-18", title: "title", body: "body"  }
    end

    assert_redirected_to admin_news_release_path(assigns(:news_release))
  end

  def test_show
    get :show, id: @news_release
    assert_response :success
  end

  def test_edit
    get :edit, id: @news_release
    assert_response :success
  end

  def test_update
    put :update, id: @news_release, news_release: { date: "2013-10-18", title: "title", body: "body"  }
    assert_redirected_to admin_news_release_path(assigns(:news_release))
  end

  def test_destroy
    assert_difference('NewsRelease.count', -1) do
      delete :destroy, id: @news_release
    end

    assert_redirected_to admin_news_releases_path
  end
end
