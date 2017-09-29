class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
  end
  def after_sign_up_path_for(_resource)
    return checkout_step_path(:address) if session[:checkout] == "checkout"
  end
end
