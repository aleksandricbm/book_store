# This Carts controller
class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items.order(id: :desc)
  end

  def update
    @coupon = find_coupon
    current_order.update_attributes(coupon_id: @coupon.id) unless @coupon.nil?
    redirect_to cart_path, notice: @coupon.nil? ? "invalid coupon" : ""
  end

  def find_coupon
    Coupon.find_by_code(params[:coupon])
  end
end
