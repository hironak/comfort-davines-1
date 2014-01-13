module Administration
  class SessionsController < BaseController

    skip_before_filter :require_login, except: [:destroy]

    def new
      @administrator = Administrator.new
    end

    def create
      user = login(params[:administrator][:username], params[:administrator][:password], params[:remember_me])
      if user
        redirect_back_or_to admin_root_path, notice: I18n.t('signed_in')
      else
        flash.now.alert = "invalid."
        render :new
      end
    end

    def create_invalid
    end

    def destroy
      logout
      redirect_to admin_root_path, notice: I18n.t('signed_out')
    end
  end
end
