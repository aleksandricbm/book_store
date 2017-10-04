# This controller for ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session

  include Current_order

  before_action :categories
  before_action :current_order

  helper_method :current_order

  add_flash_types :error, :success

  def categories
    @categories = Category.all
  end

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

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
end
