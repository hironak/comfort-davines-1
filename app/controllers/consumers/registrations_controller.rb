class Consumers::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    if params[:confirm] && resource.valid?
      render 'confirm'
    else
      super
    end
  end
end
