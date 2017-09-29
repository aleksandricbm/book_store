module Current_order
  extend ActiveSupport::Concern

  included do
    def current_order
      @current_order ||= if session[:order_id]
        Order.find(session[:order_id])
      elsif !current_user.nil? && current_user.orders.find_by(order_status_id: nil).present?
        current_user.orders.find_by(order_status_id: nil)
      else
        Order.new
      end
      rescue ActiveRecord::RecordNotFound
        reset_session
        redirect_to root_path
    end
  end
end
