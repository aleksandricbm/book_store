class CheckoutStepsController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to cart_path if current_order.order_items.count < 1
    @address = SettingAddress.new(current_user)
    @delivery = []
    render_wizard
  end

  def update
    case step
    when :address then update_address
    end
    # @address = SettingAddress.new(current_user)
    redirect_to next_wizard_path
  end

  def update_address
    @address = SettingAddress.new(current_user)
    # binding.pry
    respond_to do |format|
      if @address.save(params[:setting_address])
        binding.pry
        format.any { render template: 'checkout_steps/address' }
      else
        binding.pry
        err = {}
        err[:billing] = @address.billing.errors unless @address.billing.errors.empty?
        err[:shipping] = @address.shipping.errors unless @address.shipping.errors.empty?
        format.json { render json: err.to_json, callback: "testFunction" }
      end
    end
  end
end
