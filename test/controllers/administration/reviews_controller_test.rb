require "test_helper"

class Administration::ReviewsControllerTest < ActionController::TestCase

  before do
    @administration_review = administration_reviews(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_reviews)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Administration::Review.count') do
      post :create, administration_review: {  }
    end

    assert_redirected_to administration_review_path(assigns(:administration_review))
  end

  def test_show
    get :show, id: @administration_review
    assert_response :success
  end

  def test_edit
    get :edit, id: @administration_review
    assert_response :success
  end

  def test_update
    put :update, id: @administration_review, administration_review: {  }
    assert_redirected_to administration_review_path(assigns(:administration_review))
  end

  def test_destroy
    assert_difference('Administration::Review.count', -1) do
      delete :destroy, id: @administration_review
    end

    assert_redirected_to administration_reviews_path
  end
end
