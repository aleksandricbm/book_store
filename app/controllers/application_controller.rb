class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :error, :success

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |user|
      user.permit(:email, :password, :remember_me)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:email, :current_password, :password, :password_confirmation)
    end
  end

end
