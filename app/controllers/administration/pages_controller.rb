module Administration
  class PagesController < BaseController
    authorize_actions_for Page

    before_action :set_page, only: [:show, :edit, :update, :destroy]

    # GET /administration/pages
    # GET /administration/pages.json
    def index
      @pages = Page.all
    end

    # GET /administration/pages/1
    # GET /administration/pages/1.json
    def show
    end

    # GET /administration/pages/new
    def new
      @page = Page.new
    end

    # GET /administration/pages/1/edit
    def edit
    end

    # POST /administration/pages
    # POST /administration/pages.json
    def create
      @page = Page.new(page_params)

      respond_to do |format|
        if @page.save
          format.html { redirect_to [:admin, @page], notice: 'Page was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @page] }
        else
          format.html { render action: 'new' }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/pages/1
    # PATCH/PUT /administration/pages/1.json
    def update
      respond_to do |format|
        if @page.update(page_params)
          format.html { redirect_to [:admin, @page], notice: 'Page was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/pages/1
    # DELETE /administration/pages/1.json
    def destroy
      @page.destroy
      respond_to do |format|
        format.html { redirect_to admin_pages_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :render_type, :body, :style)
    end
  end
end
