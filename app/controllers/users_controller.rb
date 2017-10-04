class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @this_user = current_user
  end

  def update
    change_email if params[:type] == 'change_email'
    change_pwd if params[:type] == 'change_pwd'
  end

  private

  def change_email
    current_user.skip_password = true
    current_user.update(params_email)
    render :index, this_user: @current_user.errors
  end

  def change_pwd
    current_user.update_with_password(params_pwd)
    render :index, this_user: current_user.errors
  end

  def params_pwd
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def params_email
    params.permit(:email)
  end
end
