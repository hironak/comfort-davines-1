class Consumers::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    if params[:confirm] && resource.valid?
      render 'confirm'
    else
      super
    end
  end

  def complete
  end

  private

  def is_flashing_format?
    super && params[:action] != 'create'
  end

  def after_inactive_sign_up_path_for resource
    complete_path
  end
end
