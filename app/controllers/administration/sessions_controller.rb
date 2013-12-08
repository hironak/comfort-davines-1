module Administration
  class SessionsController < BaseController
    def new
    end

    def create
      user = login(params[:username], params[:password], params[:remember_me])
      if user
        redirect_back_or_to admin_root_path, notice: "Logged in!"
      else
        flash.now.alert = "invalid."
      end
    end

    def destroy
      logout
      redirect_to admin_root_path, notice: "Logged out!"
    end
  end
end
