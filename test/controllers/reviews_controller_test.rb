require "test_helper"

class ReviewsControllerTest < ActionController::TestCase

  before do
    @review = reviews(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:reviews)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Review.count') do
      post :create, review: {  }
    end

    assert_redirected_to review_path(assigns(:review))
  end

  def test_show
    get :show, id: @review
    assert_response :success
  end

  def test_edit
    get :edit, id: @review
    assert_response :success
  end

  def test_update
    put :update, id: @review, review: {  }
    assert_redirected_to review_path(assigns(:review))
  end

  def test_destroy
    assert_difference('Review.count', -1) do
      delete :destroy, id: @review
    end

    assert_redirected_to reviews_path
  end
end
