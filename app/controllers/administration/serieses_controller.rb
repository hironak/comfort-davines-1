module Administration
  class SeriesesController < BaseController
    before_action :set_series, only: [:show, :edit, :update, :destroy]

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
      @series = Series.new
    end

    # GET /administration/serieses/1/edit
    def edit
    end

    # POST /administration/serieses
    # POST /administration/serieses.json
    def create
      @series = Series.new(series_params)

      respond_to do |format|
        if @series.save
          format.html { redirect_to [:admin, @series], notice: 'Seriese was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @series] }
        else
          format.html { render action: 'new' }
          format.json { render json: @series.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/serieses/1
    # PATCH/PUT /administration/serieses/1.json
    def update
      respond_to do |format|
        if @series.update(series_params)
          format.html { redirect_to [:admin, @series], notice: 'Seriese was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @series.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/serieses/1
    # DELETE /administration/serieses/1.json
    def destroy
      @series.destroy
      respond_to do |format|
        format.html { redirect_to admin_serieses_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_series
      @series = Series.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def series_params
      params.require(:series).permit(:name)
    end
  end
end
