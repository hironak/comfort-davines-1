module Administration
  class SalonsController < BaseController
    authorize_actions_for Salon

    before_action :set_salon, only: [:show, :edit, :update, :destroy]

    # GET /administration/salons
    # GET /administration/salons.json
    def index
      @salons = Salon.all
    end

    # GET /administration/salons/1
    # GET /administration/salons/1.json
    def show
    end

    # GET /administration/salons/new
    def new
      @salon = Salon.new
    end

    # GET /administration/salons/1/edit
    def edit
    end

    # POST /administration/salons
    # POST /administration/salons.json
    def create
      @salon = Salon.new(salon_params)

      respond_to do |format|
        if @salon.save
          format.html { redirect_to [:admin, @salon], notice: 'Salon was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @salon] }
        else
          format.html { render action: 'new' }
          format.json { render json: @salon.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/salons/1
    # PATCH/PUT /administration/salons/1.json
    def update
      respond_to do |format|
        if @salon.update(salon_params)
          format.html { redirect_to [:admin, @salon], notice: 'Salon was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @salon.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/salons/1
    # DELETE /administration/salons/1.json
    def destroy
      @salon.destroy
      respond_to do |format|
        format.html { redirect_to admin_salons_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_salon
      @salon = Salon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def salon_params
      params.require(:salon).permit(:number, :name, :grade, :address, :tel, :website)
    end
  end
end
