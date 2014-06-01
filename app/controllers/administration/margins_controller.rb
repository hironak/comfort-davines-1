module Administration
  class MarginsController < BaseController
    before_action :set_agency, only: [:show, :edit, :update]

    # GET /administration/margins
    # GET /administration/margins.json
    def index
      @agencies = Agency.all
    end

    # GET /administration/margins/1
    # GET /administration/margins/1.json
    def show
    end

    # GET /administration/margins/1/edit
    def edit
      @agency.build_backmargins
    end

    # PATCH/PUT /administration/margins/1
    # PATCH/PUT /administration/margins/1.json
    def update
      respond_to do |format|
        if @agency.update(agency_params)
          format.html { redirect_to admin_margin_url(@agency), notice: 'Margin was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @agency.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_agency
      @agency = Agency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agency_params
      params[:agency]
    end
  end
end
