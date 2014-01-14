module Administration
  class SettingsController < BaseController
    before_filter :set_setting

    def show
    end

    def edit
    end

    def update
      respond_to do |format|
        if @setting.update(setting_params)
          format.html { redirect_to [:admin, :setting], notice: rmt(:successfully, :updated, @setting) }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @setting.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_setting
      @setting = Setting.instance
    end

    def setting_params
      params.require(:setting).permit(:tax)
    end
  end
end
