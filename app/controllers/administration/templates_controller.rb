module Administration
  class TemplatesController < BaseController
    before_action :set_template, only: [:show, :edit, :update, :destroy]

    # GET /administration/templates
    # GET /administration/templates.json
    def index
      @templates = Product::Template.all
    end

    # GET /administration/templates/1
    # GET /administration/templates/1.json
    def show
    end

    # GET /administration/templates/new
    def new
      @template = Product::Template.new
    end

    # GET /administration/templates/1/edit
    def edit
    end

    # POST /administration/templates
    # POST /administration/templates.json
    def create
      @template = Product::Template.new(template_params)

      respond_to do |format|
        if @template.save
          format.html { redirect_to [:admin, @template], notice: 'Template was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @template] }
        else
          format.html { render action: 'new' }
          format.json { render json: @template.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/templates/1
    # PATCH/PUT /administration/templates/1.json
    def update
      respond_to do |format|
        if @template.update(template_params)
          format.html { redirect_to [:admin, @template], notice: 'Template was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @template.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/templates/1
    # DELETE /administration/templates/1.json
    def destroy
      @template.destroy
      respond_to do |format|
        format.html { redirect_to admin_templates_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Product::Template.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params[:product_template]
    end
  end
end
