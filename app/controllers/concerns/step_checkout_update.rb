module StepCheckoutUpdate
  extend ActiveSupport::Concern

  included do

    private

    def update_complete
      current_order.update(user_id: current_user.id)
      current_order.update(number: generate_number_order) if current_order.number.nil?
      current_order.update(total_price: current_order.order_total)
      redirect_to jump_to(:complete)
    end

    def generate_number_order
      num = Order.maximum('number')
      num = num.to_i + 1
      num = 1 if num.nil?
      num.to_s.rjust(8, '0')
    end

    def update_payment
      return redirect_to skip_step if params[:credit_card].nil?
      @payment = CreditCard.find_or_initialize_by(order_id: current_order.id)
      @payment.update(order_id: current_order.id)
      @payment.update(params_payment)
      @order = current_order
      return render_wizard unless @payment.save
      redirect_steps
    end

    def params_payment
      params.require(:credit_card).permit(:number, :name, :expired, :cvv)
    end

    def update_delivery
      return redirect_to skip_step if params[:shipping_method].nil?
      unless current_order.update(shipping_method_id: params[:shipping_method][:id])
        flash[:notice] = 'Please select Shipping Method'
        return redirect_to skip_step
      end
      redirect_steps
    end

    def update_address
      @address = SettingAddress.new(current_user, current_order)
      @order = current_order
      return render_wizard unless @address.save(params[:setting_address], params[:use_billing])
      redirect_steps
    end
  end
end
