# This controller Setting
class SettingsController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource
  def show
    @address = SettingAddress.new(current_user)
  end

  def update
    @address = SettingAddress.new(current_user)
    respond_to do |format|
      if @address.save(params[:setting_address])
        format.any { render 'settings/show' }
      else
        err = {}
        err[:billing] = @address.billing.errors unless @address.billing.errors.empty?
        err[:shipping] = @address.shipping.errors unless @address.shipping.errors.empty?
        format.json { render json: err.to_json, callback: "error_parse" }
      end
    end
  end

  def order_details
    @order_details = Order.find(params[:id])
    authorize! :create, @order_details
  end

  def orders
    @order_statuses = OrderStatus.all
    if params[:filter].present?
      @orders = filter.decorate
    else
      @orders = current_user.orders.decorate
    end
    authorize! :read, @orders
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

  def filter
    Order.where(order_status_id: params[:filter].to_i).accessible_by(current_ability) if Order.find_by(order_status_id: params[:filter].to_i).present?
  end
end
