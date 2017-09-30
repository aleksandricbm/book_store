#
class SettingAddress
  include ActiveModel::Model
  include ActiveModel::Validations
  attr_accessor :billing, :shipping, :save_address

  def initialize(current_user, current_order = nil)
    @current_order = current_order.id if current_order.present?
    create_billing_address(current_user.id)
    create_shipping_address(current_user.id)
  end

  def save(params, use_billing = nil)
    @billing.order_id = @current_order && @shipping.order_id = @current_order if @current_order.present?
    return false unless @billing.update(params_address(params, :billing_address))
    if use_billing == 'on'
      return false unless @shipping.update(params_address(params, :billing_address))
    else
      return false unless @shipping.update(params_address(params, :shipping_address))
    end
    return true
  end

  private

  def create_billing_address(user_id)
    @billing = BillingAddress.find_or_initialize_by(user_id: user_id)
  end

  def create_shipping_address(user_id)
    @shipping = ShippingAddress.find_or_initialize_by(user_id: user_id)
  end

  def params_address(params, type)
    params.require(type).permit(:first_name, :last_name, :address, :city, :zip, :country_id, :phone)
  end

end
