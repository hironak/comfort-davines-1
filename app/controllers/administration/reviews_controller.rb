class Administration::ReviewsController < ApplicationController
  before_action :set_administration_review, only: [:show, :edit, :update, :destroy]

  # GET /administration/reviews
  # GET /administration/reviews.json
  def index
    @administration_reviews = Administration::Review.all
  end

  # GET /administration/reviews/1
  # GET /administration/reviews/1.json
  def show
  end

  # GET /administration/reviews/new
  def new
    @administration_review = Administration::Review.new
  end

  # GET /administration/reviews/1/edit
  def edit
  end

  # POST /administration/reviews
  # POST /administration/reviews.json
  def create
    @administration_review = Administration::Review.new(administration_review_params)

    respond_to do |format|
      if @administration_review.save
        format.html { redirect_to @administration_review, notice: 'Review was successfully created.' }
        format.json { render action: 'show', status: :created, location: @administration_review }
      else
        format.html { render action: 'new' }
        format.json { render json: @administration_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administration/reviews/1
  # PATCH/PUT /administration/reviews/1.json
  def update
    respond_to do |format|
      if @administration_review.update(administration_review_params)
        format.html { redirect_to @administration_review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @administration_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/reviews/1
  # DELETE /administration/reviews/1.json
  def destroy
    @administration_review.destroy
    respond_to do |format|
      format.html { redirect_to administration_reviews_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administration_review
      @administration_review = Administration::Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administration_review_params
      params.require(:administration_review).permit(:body, :accepted)
    end
end
