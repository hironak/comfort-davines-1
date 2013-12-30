module Administration
  class CategoriesController < BaseController
    before_action :set_administration_category, only: [:show, :edit, :update, :destroy]

    # GET /administration/categories
    # GET /administration/categories.json
    def index
      @categories = Category.all
    end

    # GET /administration/categories/1
    # GET /administration/categories/1.json
    def show
    end

    # GET /administration/categories/new
    def new
      @category = Category.new
    end

    # GET /administration/categories/1/edit
    def edit
    end

    # POST /administration/categories
    # POST /administration/categories.json
    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.html { redirect_to [:admin, @category], notice: 'Category was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @category] }
        else
          format.html { render action: 'new' }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/categories/1
    # PATCH/PUT /administration/categories/1.json
    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to [:admin, @category], notice: 'Category was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/categories/1
    # DELETE /administration/categories/1.json
    def destroy
      @category.destroy
      respond_to do |format|
        format.html { redirect_to admin_categories_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_administration_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
  end
end
