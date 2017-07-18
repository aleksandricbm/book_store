# This controller for Users::SessionsController
class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #  redirect_to '/auth/facebook'
  # end

  # POST /resource/sign_in
  ef create
  auth = request.env['omniauth.auth']
  user = User.where(provider: auth['provider'],
                    uid: auth['uid']).first || User.create_with_omniauth(auth)
  session[:user_id] = user.id
  redirect_to root_url
  nd

  # DELETE /resource/sign_out
  # def destroy
  #  reset_session
  #  redirect_to root_path
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
