module Administration
  class InformationController < BaseController
    before_filter :set_information
    before_filter :authorize_action

    def show
    end

    def edit
    end

    def update
      respond_to do |format|
        if @information.update(information_params)
          format.html { redirect_to [:admin, :information], notice: rmt(:successfully, :updated, @information) }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @information.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_information
      @information = current_administrator.contractable
    end

    def authorize_action
      authorize_action_for @information
    end

    def information_params
      case @information
      when Agency
        params.require(:agency).permit(:name)
      when Salon
        params.require(:salon).permit(:name, :name_kana, :address, :tel)
      end
    end
  end
end
