module Administration
  class PressReleasesController < BaseController
    before_action :set_press_release, only: [:show, :edit, :update, :destroy]

    # GET /administration/press_releases
    # GET /administration/press_releases.json
    def index
      @press_releases = PressRelease.rank(:row_order).all
    end

    # GET /administration/press_releases/1
    # GET /administration/press_releases/1.json
    def show
    end

    # GET /administration/press_releases/new
    def new
      @press_release = PressRelease.new
    end

    # GET /administration/press_releases/1/edit
    def edit
    end

    # POST /administration/press_releases
    # POST /administration/press_releases.json
    def create
      @press_release = PressRelease.new(press_release_params)

      respond_to do |format|
        if @press_release.save
          format.html { redirect_to [:admin, @press_release], notice: 'Press release was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @press_release] }
        else
          format.html { render action: 'new' }
          format.json { render json: @press_release.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/press_releases/1
    # PATCH/PUT /administration/press_releases/1.json
    def update
      respond_to do |format|
        if @press_release.update(press_release_params)
          format.html { redirect_to [:admin, @press_release], notice: 'Press release was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @press_release.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/press_releases/1
    # DELETE /administration/press_releases/1.json
    def destroy
      @press_release.destroy
      respond_to do |format|
        format.html { redirect_to admin_press_releases_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_press_release
      @press_release = PressRelease.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def press_release_params
      params.require(:press_release).permit(:image, :magazine, :corner, :products, :row_order_position)
    end
  end
end
