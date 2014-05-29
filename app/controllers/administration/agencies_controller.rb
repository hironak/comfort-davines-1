module Administration
  class AgenciesController < BaseController
    authorize_actions_for Agency

    before_action :set_agency, only: [:show, :edit, :update, :destroy]

    # GET /administration/agencies
    # GET /administration/agencies.json
    def index
      @agencies = Agency.all
    end

    # GET /administration/agencies/1
    # GET /administration/agencies/1.json
    def show
    end

    # GET /administration/agencies/new
    def new
      @agency = Agency.new
    end

    # GET /administration/agencies/1/edit
    def edit
    end

    # POST /administration/agencies
    # POST /administration/agencies.json
    def create
      @agency = Agency.new(agency_params)

      respond_to do |format|
        if @agency.save
          format.html { redirect_to [:admin, @agency], notice: rmt(:successfully, :created, @agency) }
          format.json { render action: 'show', status: :created, location: [:admin, @agency] }
        else
          format.html { render action: 'new' }
          format.json { render json: @agency.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/agencies/1
    # PATCH/PUT /administration/agencies/1.json
    def update
      respond_to do |format|
        if @agency.update(agency_params)
          format.html { redirect_to [:admin, @agency], notice: rmt(:successfully, :updated, @agency) }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @agency.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/agencies/1
    # DELETE /administration/agencies/1.json
    def destroy
      @agency.destroy
      respond_to do |format|
        format.html { redirect_to admin_agencies_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_agency
      @agency = Agency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agency_params
      params
        .require(:agency)
        .permit(
          :name,
          :backmargin_agency,
          :backmargin_salon,
          salon_ids: [],
          administrator_attributes: [
            :username,
            :password,
            :password_confirmation
          ]
      )
    end
  end
end
