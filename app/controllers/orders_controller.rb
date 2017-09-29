class OrdersController < ApplicationController
  load_and_authorize_resource

  def show
    @order_statuses = OrderStatus.all
    show_order_details if params[:number].present?

    if params[:filter].present?
      @orders = filter.decorate
    else
      @orders = current_user.orders.decorate
    end
  end

  private

  def show_order_details
    @order_details = Order.find(params[:number])
    return render :order_details
  end

  def filter
    return Order.where(order_status_id: params[:filter].to_i).accessible_by(current_ability) if Order.find_by(order_status_id: params[:filter].to_i).present?
    Order.none
  end
end
