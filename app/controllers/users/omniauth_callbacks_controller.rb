# This controller for Users::OmniauthCallbacksController
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    req_env = request.env['omniauth.auth']
    @user = User.from_omniauth(req_env)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = req_env
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
