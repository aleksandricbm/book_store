class CheckoutStepsController < ApplicationController
  before_action :authenticate_user!

  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to cart_path if current_order.order_items.count < 1
    @order = current_order
    case step
    when :address
      get_address
    when :delivery
      get_delivery
    when :payment
      get_delivery
      get_payment
    when :confirm
      get_address
      get_delivery
      get_payment
      get_order_items
    when :complete
      get_address
      get_delivery
      get_payment
      get_order_items

      session.delete(:order_id)
    end
    render_wizard
  end

  def update
    case step
    when :address then update_address
    when :delivery then update_delivery
    when :payment then update_payment
    when :complete then update_complete
    end
  end

  private

  def update_complete
    current_order.update(user_id: current_user.id)
    current_order.update(number: generate_number_order) if current_order.number.nil?
    current_order.update(total_price: current_order.order_total)
    current_order.update(order_status_id:OrderStatus.find_by(name: 'Waiting for processing').id)
    redirect_to jump_to(:complete)
  end

  def generate_number_order
    num = Order.maximum('number')
    num = num.to_i + 1
    num=1 if num.nil?
    num.to_s.rjust(8,'0')
  end

  def update_payment
    # flash[:notice] = "Please select CreditCard"
    return redirect_to skip_step if params[:credit_card].nil?
    @credit_card = CreditCard.find_or_initialize_by(order_id: current_order.id)
    @credit_card.update(order_id: current_order.id)
    @credit_card.update(params_payment)
    # binding.pry
    if !@credit_card.save
      flash[:errors] = @credit_card.errors
      return redirect_to skip_step
    else
      redirect_steps
    end
  end

  def params_payment
    params.require(:credit_card).permit(:number, :name, :expired, :cvv)
  end

  def update_delivery
    flash[:notice] = "Please select Shipping Method"
    return redirect_to skip_step if params[:shipping_method].nil?
    if !current_order.update(shipping_method_id: params[:shipping_method][:id])
      return redirect_to skip_step
    end
    redirect_steps
  end

  def update_address
    @address = SettingAddress.new(current_user, current_order)
    if !@address.save(params[:setting_address])
      err = {}
      err[:billing] = @address.billing.errors unless @address.billing.errors.empty?
      err[:shipping] = @address.shipping.errors unless @address.shipping.errors.empty?
      render json: err.to_json, callback: "error_parse"
    else
      return render js: "window.location = '#{wizard_path(params[:redirect])}';" if params[:redirect].present? and (params[:redirect]=='confirm' || params[:redirect]=='complete')
      render js: "window.location = '#{next_wizard_path}';"
    end
  end

  def redirect_steps
    return redirect_to wizard_path(params[:redirect]) if params[:redirect].present? and (params[:redirect]=='confirm' || params[:redirect]=='complete')
    redirect_to next_wizard_path
  end
  def get_address
    @address = SettingAddress.new(current_user)
  end
  def get_delivery
    @delivery = ShippingMethod.find_or_initialize_by(id: @order.shipping_method_id)
  end
  def get_payment
    @payment = CreditCard.find_or_initialize_by(order_id: @order.id)
  end
  def get_order_items
    @order_items = current_order.order_items.order(id: :desc)
  end
end
