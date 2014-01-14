module Administration
  class SessionsController < BaseController

    skip_before_filter :require_login, except: [:destroy]

    layout "application"

    def new
      @administrator = Administrator.new
    end

    def create
      user = login(params[:administrator][:username], params[:administrator][:password], params[:remember_me])
      if user
        redirect_back_or_to admin_root_path, notice: I18n.t('administration_session.signed_in')
      else
        @administrator = Administrator.new
        flash.now[:notice] = I18n.t('administration_session.sign_in_invalid')
        render :new
      end
    end

    def destroy
      logout
      redirect_to admin_login_path, notice: I18n.t('administration_session.signed_out')
    end
  end
end
