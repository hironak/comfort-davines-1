module Administration
  class SeriesesController < BaseController
    before_action :set_seriese, only: [:show, :edit, :update, :destroy]

    # GET /administration/serieses
    # GET /administration/serieses.json
    def index
      @serieses = Series.all
    end

    # GET /administration/serieses/1
    # GET /administration/serieses/1.json
    def show
    end

    # GET /administration/serieses/new
    def new
      @seriese = Series.new
    end

    # GET /administration/serieses/1/edit
    def edit
    end

    # POST /administration/serieses
    # POST /administration/serieses.json
    def create
      @seriese = Series.new(seriese_params)

      respond_to do |format|
        if @seriese.save
          format.html { redirect_to [:admin, @seriese], notice: 'Seriese was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @seriese] }
        else
          format.html { render action: 'new' }
          format.json { render json: @seriese.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/serieses/1
    # PATCH/PUT /administration/serieses/1.json
    def update
      respond_to do |format|
        if @seriese.update(seriese_params)
          format.html { redirect_to [:admin, @seriese], notice: 'Seriese was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @seriese.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/serieses/1
    # DELETE /administration/serieses/1.json
    def destroy
      @seriese.destroy
      respond_to do |format|
        format.html { redirect_to admin_serieses_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_seriese
      @seriese = Series.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seriese_params
      params.require(:seriese).permit(:name)
    end
  end
end
