# This Carts controller
class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items.order(id: :desc)
  end

  def update
    @order = current_order
    @order.coupon_id = Coupon.find_by(code: params[:coupon]).id
      rescue NoMethodError
        return redirect_to cart_path
    @order.save
    redirect_to cart_path

  end
end
