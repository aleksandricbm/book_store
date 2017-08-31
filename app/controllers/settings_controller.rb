# This controller Setting
class SettingsController < ApplicationController

  def show
    @address = SettingAddress.new(current_user)
  end

  def update
    @address = SettingAddress.new(current_user)
    respond_to do |format|
      if @address.save(params[:setting_address])
        format.any { render template: 'settings/show' }
      else
        err = {}
        err[:billing] = @address.billing.errors unless @address.billing.errors.empty?
        err[:shipping] = @address.shipping.errors unless @address.shipping.errors.empty?
        format.json { render json: err.to_json, callback: "error_parse" }
      end
    end
  end

  def change_email
    current_user.update(email: params[:email])
  end

  def change_pwd
    current_user.valid_password?(params[:user][:old_password])
  end

  private

  def set_new_password
  end
end
