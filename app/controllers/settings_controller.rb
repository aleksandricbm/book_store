# This controller Setting
class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @address = SettingAddress.new(current_user)
  end

  def create
    @address = SettingAddress.new(current_user)
    @address.save(params[:setting_address])
    render :index, object: @address.errors
  end
end
