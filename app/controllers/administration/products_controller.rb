module Administration
  class ProductsController < BaseController
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    # GET /products
    # GET /products.json
    def index
      @products = Product.unscoped.load
    end

    # GET /products/1
    # GET /products/1.json
    def show
      if @page = @product.page
        scss = render_to_string('editable', formats: :scss)
        @editable_style = Sass::Engine.new(scss, syntax: :scss).render
      end
    end

    # GET /products/new
    def new
      @product = Product.new
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products
    # POST /products.json
    def create
      @product = Product.new(product_params)

      respond_to do |format|
        if @product.save
          format.html { redirect_to [:admin, @product], notice: 'Product was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @product] }
        else
          format.html { render action: 'new' }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /products/1
    # PATCH/PUT /products/1.json
    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to [:admin, @product], notice: 'Product was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /products/1
    # DELETE /products/1.json
    def destroy
      @product.destroy
      respond_to do |format|
        format.html { redirect_to admin_products_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.unscoped.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :image, :stock, :sample, :category_id, :series_id, :page_id)
    end
  end
end
