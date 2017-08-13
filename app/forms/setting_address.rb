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

  def initialize (current_user)
    create_billing_address(current_user.id)
    create_shipping_address(current_user.id)
  end

  def save (params)
    @billing.update(params_address(params,:billing_address))
    @shipping.update(params_address(params,:shipping_address))
  end

  private

  def create_billing_address (user_id)
    @billing = BillingAddress.find_by(user_id: user_id)
    unless @billing.present?
      @billing = BillingAddress.new(user_id: user_id)
      @billing.save
    end
  end

  def create_shipping_address (user_id)
    @shipping = ShippingAddress.find_by(user_id: user_id)
    unless @shipping.present?
      @shipping = ShippingAddress.new(user_id: user_id)
      @shipping.save
    end
  end

  def params_address(params, type)
    # binding.pry
    params.require(type).permit(:first_name,:last_name,:address,:city,:zip,:phone)
  end

  # def promote_errors(type,child_errors)
  #   child_errors.each do |attribute, message|
  #     errors.add(attribute, message)
  #   end
  # end
end
