class CheckoutStepsController < ApplicationController
  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to cart_path if current_order.order_items.count < 1

    case step
    when :address
      @address = SettingAddress.new(current_user)
    when :delivery
      @delivery = ShippingMethod.new
    end
    render_wizard
  end

  def update
    case step
    when :address then update_address
    when :delivery then update_delivery
    end
    # @address = SettingAddress.new(current_user)
    # redirect_to next_wizard_path
  end

  def update_delivery
    binding.pry
    flash[:notice] = "Please select Shipping Method"
    return redirect_to skip_step if params[:shipping_method].nil?
    if !current_order.update(shipping_methods_id: params[:shipping_method][:id])
      return redirect_to skip_step
    end
    redirect_to next_wizard_path
  end

  def update_address
    @address = SettingAddress.new(current_user, current_order)
    if !@address.save(params[:setting_address])
      err = {}
      err[:billing] = @address.billing.errors unless @address.billing.errors.empty?
      err[:shipping] = @address.shipping.errors unless @address.shipping.errors.empty?
      render json: err.to_json, callback: "error_parse"
    else
      render js: "window.location = '#{next_wizard_path}';"
    end

  end
end
