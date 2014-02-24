class Consumers::RegistrationsController < Devise::RegistrationsController

  protected

  def configure_permitted_parameters
    devise_perrameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, information_attributes: [
        :family_name,
        :given_name,
        :family_name_kana,
        :given_name_kana,
        :postalcode,
        :prefecture_code,
        :address,
        :building,
        :phone,
      ])
    end
  end
end
