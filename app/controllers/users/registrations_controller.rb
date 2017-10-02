class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    UserMailer.confirmation_mail(params[:user][:email], params[:user][:password]).deliver_now if current_user.present?
  end
  def after_sign_up_path_for(_resource)
    return checkout_step_path(:address) if session[:checkout] == 'checkout'
  end
end
