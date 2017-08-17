# This controller Setting
class SettingsController < ApplicationController

  def show
    @address = SettingAddress.new(current_user)
  end

  def update
    binding.pry
    @address = SettingAddress.new(current_user)
    respond_to do |format|
      if @address.save(params[:setting_address])
        format.any { render template: 'settings/show' }
      else
        err = {}
        err[:billing] = @address.billing.errors unless @address.billing.errors.empty?
        err[:shipping] = @address.shipping.errors unless @address.shipping.errors.empty?
        format.json { render json: err.to_json, callback: "testFunction" }
      end
    end
  end

  def change_email
    @user = current_user
    @user.update(email: params[:email])
    @user.save
  end

  def change_pwd
    @user = current_user
    true if @user.valid_password?(params[:user][:old_password])
    false
  end

  private

  def set_new_password
  end
end
