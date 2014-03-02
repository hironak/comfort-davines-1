module Administration
  class ReviewsController < BaseController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /administration/reviews
  # GET /administration/reviews.json
  def index
    @reviews = Product::Review.unscope
  end

  # GET /administration/reviews/1
  # GET /administration/reviews/1.json
  def show
  end

  # GET /administration/reviews/1/edit
  def edit
  end

  # PATCH/PUT /administration/reviews/1
  # PATCH/PUT /administration/reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/reviews/1
  # DELETE /administration/reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Product::Review.unscope.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:body, :accepted)
    end
end
