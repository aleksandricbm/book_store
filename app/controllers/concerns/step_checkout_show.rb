module StepCheckoutShow
  extend ActiveSupport::Concern

  included do

    private

    def step_jump(specific_step)
      case specific_step
      when :address
        address
      when :delivery
        delivery
      when :payment
        delivery
        payment
      when :confirm
        address
        delivery
        payment
        order_items
      when :complete
        address
        delivery
        payment
        order_items
      end
    end

    def address
      @address = SettingAddress.new(current_user)
    end

    def delivery
      return jump_to(:address) unless current_order.billing_address.present?
      @delivery = ShippingMethod.find_or_initialize_by(id: @order.shipping_method_id)
    end

    def payment
      return jump_to(:delivery) unless current_order.shipping.present?
      @payment = CreditCard.find_or_initialize_by(order_id: @order.id)
    end

    def order_items
      return jump_to(:payment) unless current_order.credit_card.present?
      @order_items = current_order.order_items.order(id: :desc)
      if @step == 'complate'
        current_order.update(order_status_id: 1)
        session.delete(:order_id)
      end
    end
  end
end
