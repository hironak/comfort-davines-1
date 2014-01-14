module Administration
  class AdministratorsController < BaseController
    authorize_actions_for Administrator

    before_action :set_administrator, only: [:show, :edit, :update, :destroy]

    # GET /administration/administrators
    # GET /administration/administrators.json
    def index
      @administrators = Administrator.all
    end

    # GET /administration/administrators/1
    # GET /administration/administrators/1.json
    def show
    end

    # GET /administration/administrators/new
    def new
      @administrator = Administrator.new
    end

    # GET /administration/administrators/1/edit
    def edit
    end

    # POST /administration/administrators
    # POST /administration/administrators.json
    def create
      @administrator = Administrator.new(administrator_params)

      respond_to do |format|
        if @administrator.save
          format.html { redirect_to [:admin, @administrator], notice: rmt(:successfully, :created, @administrator) }
          format.json { render action: 'show', status: :created, location: [:admin, @administrator] }
        else
          format.html { render action: 'new' }
          format.json { render json: @administrator.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/administrators/1
    # PATCH/PUT /administration/administrators/1.json
    def update
      respond_to do |format|
        if @administrator.update(administrator_params)
          format.html { redirect_to [:admin, @administrator], notice: rmt(:successfully, :updated, @administrator) }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @administrator.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/administrators/1
    # DELETE /administration/administrators/1.json
    def destroy
      @administrator.destroy
      respond_to do |format|
        format.html { redirect_to admin_administrators_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator
      @administrator = Administrator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_params
      params.require(:administrator).permit(:username, :password, :password_confirmation)
    end
  end
end
