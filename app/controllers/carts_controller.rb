# This Carts controller
class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items.order(id: :desc)
  end
end
