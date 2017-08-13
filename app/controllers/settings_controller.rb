# This controller Setting
class SettingsController < ApplicationController

  def show
    # @user = current_user
    # @billing = BillingAddress.new
    # @billing = BillingAddress.find(current_user.id) if BillingAddress.find_by(user_id: current_user.id)
    # @shipping = ShippingAddress.new
    # @shipping = ShippingAddress.find(current_user.id) if ShippingAddress.find_by(user_id: current_user.id)
    @address = SettingAddress.new(current_user)
    # binding.pry
  end

  def update
    # binding.pry
    @address = SettingAddress.new(current_user)
    # @address.save(params[:setting_address])
    # binding.pry
    # if @address.save(params[:setting_address])
    #   p 'ww'
    # else
    #   render :json => { :errors => @address.billing.errors.full_messages }, :status => 422
    # end
    respond_to do |format|
      if @address.save(params[:setting_address])
        # # binding.pry
        # flash[:success] = "Address successfully update!"
        # # redirect_to setting_url, notice: 'Registration successful!'
        # # redirect_to setting_path
        # render :show
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
    binding.pry
    @user = current_user
    @user.update(email: params[:email])
    @user.save
  end

  def change_pwd
    binding.pry
    @user = current_user
    true if @user.valid_password?(params[:user][:old_password])
    false
  end

  private

  def set_new_password
  end
end
