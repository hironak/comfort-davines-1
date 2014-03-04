require "test_helper"

class ReviewsControllerTest < ActionController::TestCase

  # before do
  #   @review = create(:review)
  # end

  # def test_index
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:reviews)
  # end

  # def test_new
  #   get :new
  #   assert_response :success
  # end

  def test_create
    @product = create(:product)
    assert_difference('Product::Review.unscoped.count') do
      post :create, product_review: { name: "hoge", subject: "huga", body: "Review", product_id: @product.id }
    end

    assert_redirected_to product_path(@product)
  end

  # def test_show
  #   get :show, id: @review
  #   assert_response :success
  # end

  # def test_edit
  #   get :edit, id: @review
  #   assert_response :success
  # end

  # def test_update
  #   put :update, id: @review, review: {  }
  #   assert_redirected_to review_path(assigns(:review))
  # end

  # def test_destroy
  #   assert_difference('Review.count', -1) do
  #     delete :destroy, id: @review
  #   end

  #   assert_redirected_to reviews_path
  # end
end
