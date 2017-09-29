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
        current_order.update(order_status_id: 1)
        session.delete(:order_id)
      end
    end

    def address
      @address = SettingAddress.new(current_user)
    end

    def delivery
      @delivery = ShippingMethod.find_or_initialize_by(id: @order.shipping_method_id)
    end

    def payment
      @payment = CreditCard.find_or_initialize_by(order_id: @order.id)
    end

    def order_items
      @order_items = current_order.order_items.order(id: :desc)
    end
  end
end
