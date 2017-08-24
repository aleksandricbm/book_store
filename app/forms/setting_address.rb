class SettingAddress
  include ActiveModel::Model
  include Virtus
  include ActiveModel::Validations
  attr_accessor :billing, :shipping, :save_address

  # attribute :first_name, String
  # attribute :last_name, String
  # attribute :address, String
  # attribute :city, String
  # attribute :zip, Integer
  # attribute :phone, String

  # validates :first_name, presence: true, length: {minimum: 2}
  # validates :last_name, presence: true, length: {minimum: 2}
  # validates :address, presence: true, length: {minimum: 5}
  # validates :city, presence: true, length: {minimum: 3}
  # validates :zip, numericality: { only_integer: true }
  # validates :phone, numericality: true

  def initialize (current_user, current_order = nil)
    @current_order = current_order.id if current_order.present?
    create_billing_address(current_user.id)
    create_shipping_address(current_user.id)
  end

  def save (params)
    # binding.pry
    @billing.order_id=@current_order && @shipping.order_id=@current_order if @current_order.present?
    # binding.pry
    @billing.update(params_address(params,:billing_address))
    @shipping.update(params_address(params,:shipping_address))
  end

  private

  def create_billing_address (user_id)
    # binding.pry
    @billing = BillingAddress.find_or_initialize_by(user_id: user_id)
    @billing.save
  end

  def create_shipping_address (user_id)
    @shipping = ShippingAddress.find_or_initialize_by(user_id: user_id)
    @shipping.save
  end

  def params_address(params, type)
    params.require(type).permit(:first_name,:last_name,:address,:city,:zip,:phone)
  end

end
